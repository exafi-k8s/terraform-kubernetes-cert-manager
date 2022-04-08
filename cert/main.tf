variable "hosts" {
  description = "dnsNames to request in CSR"
  type = list(string)
}

variable "name" {
  description = "the name of the certificate CRO in k8s"
  type = string
}

variable "secret_name" {
  description = "the secret name in k8s.  will be name-tls if not specified"
  type = string
  default = ""
}
locals {
  secret_name = var.secret_name == "" ? "${var.name}-tls" : var.secret_name
}

variable "namespace" {
  description = "kubernetes namespace to place the certificate request and resulting secret in"
  type = string
  default = "default"
}

variable "issuer" {
  description = "issuer module to issue with.  if not set, will use a ClusterIssuer named ca."
  type = object({
    kind = string
    name = string
  })
  default = {
    kind = "ClusterIssuer"
    name = "ca"
  }
}

resource "kubernetes_manifest" "certificate" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind" = "Certificate"
    "metadata" = {
      "name" = var.name
      "namespace" = var.namespace
    }
    "spec" = {
      "dnsNames" = var.hosts
      "issuerRef" = var.issuer
      "secretName" = local.secret_name
    }
  }
}
