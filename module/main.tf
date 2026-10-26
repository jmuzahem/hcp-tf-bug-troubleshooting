locals {
  jwt_mount = "jwt-${var.k8s_cluster_name}"
}

resource "vault_jwt_auth_backend" "kubernetes_cluster" {
  path = local.jwt_mount
  type = "jwt"
  jwt_validation_pubkeys = var.k8s_cluster_public_signing_keys
}