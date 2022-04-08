variable "validity_period_hours" {
  type = number
  default = 24*365*10+58 #leap hours for 10 years
}

variable "common_name" {
  type = string
}

variable "cluster_issuer_name" {
  type = string
  default = "local-ca"
}

variable "namespace" {
  type = string
  default = "cert-manager"
}

variable "create_cluster_issuer" {
  type = bool
  default = true
}

output "cluster_issuer" {
  value = var.create_cluster_issuer ? var.cluster_issuer_name : ""
}

output "name" {
  value = var.create_cluster_issuer ? var.cluster_issuer_name : ""
}

output "namespace" {
  value = var.namespace
}

output "kind" {
  value = "ClusterIssuer"
}
