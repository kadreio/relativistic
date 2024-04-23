import pulumi
import pulumi_kubernetes as kubernetes
from pulumi_kubernetes.core.v1 import PersistentVolume, PersistentVolumeClaim

# Create a new Kubernetes Persistent Volume
pv = PersistentVolume(
    "my-pv",
    metadata={
        "name": "duckdb-storage",  # The name of the Persistent Volume
    },
    spec={
        "capacity": {
            "storage": "5Gi",  # The storage capacity of the Persistent Volume
        },
        "accessModes": ["ReadWriteOnce"],  # The Persistent Volume will be mounted as read-write by a single node
        "persistentVolumeReclaimPolicy": "Retain",  # The reclaim policy for the Persistent Volume
        "hostPath": {
            "path": "/data/pv0001/",  # The path to the directory on the host, adjust according to your backend
        }
    }
)

pvc = PersistentVolumeClaim(
    "my-pvc",
    metadata={"name": "duckdb-storage-claim"},
    spec={
        "access_modes": ["ReadWriteOnce"],
        "resources": {
            "requests": {
                "storage": "5Gi"
            }
        },
        # The selector is omitted to allow the claim to bind to any available PersistentVolume with a matching class
    }
)




airbyte = kubernetes.helm.v3.Release(
    "airbyte",
    kubernetes.helm.v3.ReleaseArgs(
        chart="airbyte",
        version="0.64.81",
        repository_opts=kubernetes.helm.v3.RepositoryOptsArgs(
            repo="https://airbytehq.github.io/helm-charts"
        ),
        value_yaml_files=[pulumi.FileAsset("./airbyte.yaml")],
    ),
)

kubernetes.helm.v3.Release(
    "superset",
    kubernetes.helm.v3.ReleaseArgs(
        chart="superset",
        version="0.12.9",
        repository_opts=kubernetes.helm.v3.RepositoryOptsArgs(
            repo="https://apache.github.io/superset"
        ),
        value_yaml_files=[pulumi.FileAsset("./superset_values.yaml")],

    ),
)

kubernetes.helm.v3.Release(
    "dagster",
    kubernetes.helm.v3.ReleaseArgs(
        chart="dagster",
        version="1.7.1",
        repository_opts=kubernetes.helm.v3.RepositoryOptsArgs(
            repo="https://dagster-io.github.io/helm"
        ),
        value_yaml_files=[pulumi.FileAsset("./dagster_values.yaml")],

    ),

)


service = kubernetes.core.v1.Service(
    "my-service",
    metadata=kubernetes.meta.v1.ObjectMetaArgs(
        name="wargle-garble",  # The name of the service to expose.
        # Make sure to set the namespace to match the Helm chart's if it was defined.
    ),
    spec=kubernetes.core.v1.ServiceSpecArgs(
        type="NodePort",  # This will create a cloud provider-specific load balancer to expose the service.
        ports=[kubernetes.core.v1.ServicePortArgs(
            port=8080,  # The port to expose on the load balancer.
            target_port=8080,  # The port your service is listening on (specify as needed).
            node_port=30080,  # Port accessible outside cluster, chosen by you if available

        )],
        selector={
            "airbyte_deploy": "webapp",  # Update this selector to match the labels of the pods created by the Helm chart.
        },
    )
)

service = kubernetes.core.v1.Service(
    "expose-superset",
    metadata=kubernetes.meta.v1.ObjectMetaArgs(
        name="expose-superset",  # The name of the service to expose.
        # Make sure to set the namespace to match the Helm chart's if it was defined.
    ),
    spec=kubernetes.core.v1.ServiceSpecArgs(
        type="NodePort",  # This will create a cloud provider-specific load balancer to expose the service.
        ports=[kubernetes.core.v1.ServicePortArgs(
            port=8088,  # The port to expose on the load balancer.
            target_port=8088,  # The port your service is listening on (specify as needed).
            node_port=30081,  # Port accessible outside cluster, chosen by you if available

        )],
        selector={
            "app": "superset",  # Update this selector to match the labels of the pods created by the Helm chart.
        },
    )
)

# print(airbyte)
# Export the load balancer's ingress IP or hostname to access the service externally.
# pulumi.export('z', airbyte)

# Export the service's load balancer IP or hostname if applicable.
# pulumi.export('nginx_service_url', service.status.apply(lambda s: s.load_balancer.ingress[0].hostname if s.load_balancer else None))

# Export the name of the Persistent Volume
pulumi.export("persistentVolumeName", pv.metadata["name"])
