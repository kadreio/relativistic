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