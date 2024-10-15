#!/bin/bash

set -e

# Configure dependencies
sh ./configure_testing.sh

# Set a specific name for the test cluster
TEST_CLUSTER_NAME="relativistic-test-cluster"

# Function to clean up the cluster
cleanup_cluster() {
    echo "Cleaning up..."
    $(go env GOPATH)/bin/kind delete cluster --name "${TEST_CLUSTER_NAME}"
    echo "Test cluster deleted."
}

# Trap to ensure cleanup happens even if the script fails
trap cleanup_cluster EXIT

# Check if the cluster already exists and delete it if it does
if $(go env GOPATH)/bin/kind get clusters | grep -q "${TEST_CLUSTER_NAME}"; then
    echo "Test cluster already exists. Deleting it..."
    cleanup_cluster
fi

echo "Creating kind cluster for testing..."
$(go env GOPATH)/bin/kind create cluster --name "${TEST_CLUSTER_NAME}"

# Get the kubeconfig for the new cluster
TEST_KUBECONFIG=$($(go env GOPATH)/bin/kind get kubeconfig --name ${TEST_CLUSTER_NAME})

echo "Running E2E tests..."
KUBECONFIG="${TEST_KUBECONFIG}" go test -v ./test

echo "Tests completed successfully!"

# The cleanup will happen automatically due to the trap
