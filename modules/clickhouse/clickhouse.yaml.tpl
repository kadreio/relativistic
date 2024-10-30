apiVersion: "clickhouse.altinity.com/v1"
kind: "ClickHouseInstallation"
metadata:
  name: "ch-${name}"
spec:
  configuration:
    users:
      # printf 'test_password' | sha256sum
      test_user/password_sha256_hex: ${clickhouse_password_sha256_hex}
      # to allow access outside from kubernetes
      test_user/networks/ip:
        - 0.0.0.0/0
    clusters:
      - name: "ch-${name}"
        templates:
          podTemplate: pod-template-with-volumes-${name}
        layout:
          shardsCount: 1
          replicasCount: 1

  templates:
    podTemplates:
      - name: ch-pod-template-${name}
        spec:
          containers:
            - name: clickhouse
              image: clickhouse/clickhouse-server:23.8
              volumeMounts:
                - name: data-storage-vc-template-1-${name}
                  mountPath: /data/clickhouse-01

    volumeClaimTemplates:
      - name: ch-vc-template-1-${name}
        spec:
          storageClassName: "${name}"
          accessModes:
            - ReadWriteOnce
          resources:
            requests:
              storage: 1Gi