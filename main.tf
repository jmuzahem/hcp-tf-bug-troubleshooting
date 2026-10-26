locals {
  role_name = "app-${var.k8s_cluster_name}"
}

resource "vault_policy" "app" {
  count = var.auth_approle ? 1 : 0

  name = "${local.role_name}-policy"

  policy = <<-EOT
    path "secret/data/${local.role_name}/*" {
      capabilities = ["read"]
    }
  EOT
}

resource "vault_approle_auth_backend_role" "app" {
  count = var.auth_approle ? 1 : 0

  backend        = var.approle_mount
  role_name      = local.role_name
  bind_secret_id = true

  token_type              = "batch"
  token_no_default_policy = true
  token_policies          = [vault_policy.app[0].name]

  token_ttl     = var.approle_token_ttl
  token_max_ttl = var.approle_token_max_ttl

  secret_id_ttl      = var.approle_secret_id_ttl
  secret_id_num_uses = var.approle_secret_id_num_uses

  # CIDR binding is unused by test agreement; the Secret ID is usable from any source.
  secret_id_bound_cidrs = []
  token_bound_cidrs     = []
}