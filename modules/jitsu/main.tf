resource "helm_release" "jitsu" {

  name = "jitsu"
  chart = "oci://registry-1.docker.io/stafftasticcharts/jitsu"
  version = "1.5.0"

#   values = [file("${path.module}/helm_values.yaml")]
}
