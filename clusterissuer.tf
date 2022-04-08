
resource "kubectl_manifest" "local-ca" {
  yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: "${var.cluster_issuer_name}"
spec:
  ca:
    secretName: "${local.internal_ca_key_pair_secret_name}"
YAML

  depends_on = [helm_release.cert-manager]
}

#resource "kubernetes_manifest" "le-staging" {
#  manifest = {
#    "apiVersion" = "cert-manager.io/v1"
#    "kind"       = "ClusterIssuer"
#    "metadata" = {
#      "name"      = "letsencrypt-staging"
#      "namespace" = "cert-manager"
#    }
#    "spec" = {
#      "acme" = {
#        "email" = "letsencrypt@strudelline.net"
#        "server" = "https://acme-staging-v02.api.letsencrypt.org/directory"
#        "privateKeySecretRef" = {
#          "name" = "strudelline-issuer-account-key"
#        }
#        "solvers" = [
#          {
#            "dns01" = {
#              "cnameStrategy" = "Follow"
#              "digitalocean" = {
#                "tokenSecretRef" = {
#                  "name" = "digitalocean-dns"
#                  "key" = "access-token"
#                }
#              }
#            }
#            "selector" = {
#              "dnsZones" = [
#                "strudelline.net"
#              ]
#            }
#          }
#        ]
#      }
#    }
#  }
#}
