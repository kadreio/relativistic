from kubernetes import client, config
import click
import subprocess

@click.command()
@click.argument('first', nargs=1)
@click.argument('second', nargs=1)
def expose_airbyte(first, second):

    config.load_kube_config()

    # kubectl port-forward $(kubectl get pods -l airbyte_deploy=webapp -o name) 8080:5959 --address 0.0.0.0

    # Setup API
    core_v1_api = client.CoreV1Api()

    # Name of the pod and the ports
    pod = core_v1_api.list_namespaced_pod('default', label_selector='airbyte_deploy=webapp').items[0]
    pod_name = pod.metadata.name
    

    # ports = f"{local_port}:{remote_port}"

    # Forwarding command
    command = [
        "kubectl", "port-forward",
        "--namespace", 'default',
        pod_name,
        '8080:5959'
    ]

    # Running the port-forward command
    try:
        proc = client.api_client.ApiClient().util.run_process(command)
        print(f"Port forwarding setup: {8080} -> {5959}")
        proc.communicate()
    except Exception as e:
        print(f"An error occurred: {e}")


if __name__ == '__main__':
    expose_airbyte()