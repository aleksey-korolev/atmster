#
# Self-Signed TLS Certificate for Testing
#

resource "tls_private_key" "atmster" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "atmster" {
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
  dns_names             = [var.rest_api_domain_name]
  key_algorithm         = tls_private_key.atmster.algorithm
  private_key_pem       = tls_private_key.atmster.private_key_pem
  validity_period_hours = 12

  subject {
    common_name  = var.rest_api_domain_name
    organization = "ATMster"
  }
}

resource "aws_acm_certificate" "atmster" {
  certificate_body = tls_self_signed_cert.atmster.cert_pem
  private_key      = tls_private_key.atmster.private_key_pem
}
