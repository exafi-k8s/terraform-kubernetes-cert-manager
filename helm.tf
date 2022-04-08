resource "kubernetes_namespace" "cert-manager" {
  metadata {
    labels = {
      "name" = var.namespace
    }
    name = var.namespace
  }
}

resource "helm_release" "cert-manager" {
  name = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart = "cert-manager"
  version = "v1.8.0"
  namespace = kubernetes_namespace.cert-manager.id

  set {
    name = "installCRDs"
    value = "true"
  }
}

