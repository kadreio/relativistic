#
# AWS resizable disk example
#
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: "${name}"
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
reclaimPolicy: Delete
#volumeBindingMode: Immediate
allowVolumeExpansion: true
---
apiVersion: "clickhouse.altinity.com/v1"
kind: "ClickHouseInstallation"
metadata:
  name: "pv-multi-resize-${name}"
spec:
  configuration:
    users:
      # printf 'test_password' | sha256sum
      test_user/password_sha256_hex: 10a6e6cc8311a3e2bcc09bf6c199adecd5dd59408c343e926b129c4914f3cb01
      # to allow access outside from kubernetes
      test_user/networks/ip:
        - 0.0.0.0/0
    clusters:
      - name: "pv-multi-resize-${name}"
        templates:
          podTemplate: pod-template-with-volumes-${name}
        layout:
          shardsCount: 1
          replicasCount: 1

  templates:
    podTemplates:
      - name: pod-template-with-volumes-${name}
        spec:
          containers:
            - name: clickhouse
              image: clickhouse/clickhouse-server:23.8
              volumeMounts:
                - name: data-storage-vc-template-1-${name}
                  mountPath: /data/clickhouse-01

    volumeClaimTemplates:
      - name: data-storage-vc-template-1-${name}
        spec:
          storageClassName: "${name}"
          accessModes:
            - ReadWriteOnce
          resources:
            requests:
              storage: 1Gi