package test

import (
	"context"
	"fmt"
	"os"
	"path/filepath"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/k8s"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	v1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/tools/clientcmd"
)

const testClusterName = "relativistic-test-cluster"

func TestSuperset(t *testing.T) {
	t.Parallel()

	// Create a temporary directory for Terraform state and kubeconfig
	tempDir, err := os.MkdirTemp("", "terraform-test")
	require.NoError(t, err)
	defer os.RemoveAll(tempDir)

	// Write kubeconfig to a file
	kubeconfigPath := filepath.Join(os.Getenv("HOME"), ".kube", "config")
	// err = os.WriteFile(kubeconfigPath, []byte(os.Getenv("KUBECONFIG")), 0644)
	// require.NoError(t, err)

	terraformOptions := &terraform.Options{
		TerraformDir: ".", // Use the current directory (test/)
		Vars: map[string]interface{}{
			"kubernetes_config_path": func() string {
				if kubeconfig := os.Getenv("KUBECONFIG"); kubeconfig != "" {
					return kubeconfigPath
				}
				return filepath.Join(os.Getenv("HOME"), ".kube", "config")
			}(),
		},
		// Set the state file path to the temporary directory
		BackendConfig: map[string]interface{}{
			"path": filepath.Join(tempDir, "terraform.tfstate"),
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// Create kubectl options for the specific test cluster
	k8sOptions := k8s.NewKubectlOptions("", kubeconfigPath, "default")

	// Explicitly set the kubeconfig in the environment
	os.Setenv("KUBECONFIG", kubeconfigPath)

	// Create a Kubernetes client configuration
	_, err = clientcmd.BuildConfigFromFlags("", kubeconfigPath)
	require.NoError(t, err)

	// Create a new Kubernetes client
	client, err := k8s.GetKubernetesClientFromOptionsE(t, k8sOptions)
	require.NoError(t, err)

	// Function to list and print available pods
	listPods := func() {
		pods, err := client.CoreV1().Pods("").List(context.Background(), metav1.ListOptions{})
		if err != nil {
			t.Logf("Error listing pods: %v", err)
			return
		}
		t.Logf("Available pods:")
		for _, pod := range pods.Items {
			t.Logf("- %s (%s)", pod.Name, pod.Status.Phase)
		}
	}

	// Function to get the Superset pod
	getSupersetPod := func() (*v1.Pod, error) {
		pods, err := client.CoreV1().Pods("").List(context.Background(), metav1.ListOptions{
			LabelSelector: "app=superset",
		})
		if err != nil {
			return nil, err
		}
		if len(pods.Items) == 0 {
			return nil, fmt.Errorf("no Superset pod found")
		}
		return &pods.Items[0], nil
	}

	// Start a goroutine to list pods every 30 seconds
	stopListing := make(chan struct{})
	go func() {
		ticker := time.NewTicker(30 * time.Second)
		defer ticker.Stop()
		for {
			select {
			case <-ticker.C:
				listPods()
			case <-stopListing:
				return
			}
		}
	}()

	// Wait for Superset pod to be ready
	require.Eventually(t, func() bool {
		pod, err := getSupersetPod()
		if err != nil {
			t.Logf("Error getting Superset pod: %v", err)
			return false
		}
		return k8s.IsPodAvailable(pod)
	}, 10*time.Minute, 30*time.Second, "Timed out waiting for Superset pod to be available")

	// Stop the pod listing goroutine
	close(stopListing)

	// Get Superset service
	service, err := k8s.GetServiceE(t, k8sOptions, "superset")
	require.NoError(t, err)

	// Check if service is created and has the correct port
	assert.Equal(t, int32(8080), service.Spec.Ports[0].Port)

	// You can add more specific tests here, such as:
	// - Checking if Superset UI is accessible
	// - Verifying Superset API responses
	// - Testing user authentication
}
