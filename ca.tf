resource "tls_self_signed_cert" "ca-cert" {
  private_key_pem = tls_private_key.ca-key.private_key_pem

  subject {
    common_name  = var.common_name
    organization = "${var.common_name} CA"
  }

  is_ca_certificate = true

  validity_period_hours = var.validity_period_hours

  allowed_uses = [
    "cert_signing",
    "crl_signing",
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]

  set_subject_key_id = true
}

resource "tls_private_key" "ca-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

locals {
  internal_ca_key_pair_secret_name = "internal-ca-key-pair"
}

resource "kubernetes_secret" "internal-ca-key-pair" {
  metadata {
    name = local.internal_ca_key_pair_secret_name
    namespace = kubernetes_namespace.cert-manager.id
  }

  data = {
    "tls.key" = tls_private_key.ca-key.private_key_pem
    "tls.crt" = tls_self_signed_cert.ca-cert.cert_pem
  }
}
