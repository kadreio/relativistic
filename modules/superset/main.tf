
# resource "aws_route53_record" "cert_validation" {
#   name    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_name
#   type    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_type
#   zone_id = aws_route53_zone.superset_zone.zone_id
#   records = [aws_acm_certificate.cert.domain_validation_options.0.resource_record_value]
#   ttl     = 60
# }

resource "helm_release" "superset" {
  name       = "superset"
  repository = "https://apache.github.io/superset"
  chart      = "superset"
  version    = "0.12.9"

  values = [
    templatefile("${path.module}/helm_values.yaml", { superset_default_user = var.superset_default_user, superset_default_password = var.superset_default_password, superset_secret_key = var.superset_secret_key})
  ]
}
