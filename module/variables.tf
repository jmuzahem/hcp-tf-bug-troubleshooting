variable "k8s_cluster_name" {
  description = "Name of the Kubernetes cluster used to identify its Vault JWT auth mount."
  type        = string
  default     = "my-k8s-cluster"
}

variable "k8s_cluster_public_signing_keys" {
  description = "Public signing keys used by Vault to validate JWTs issued for the Kubernetes cluster."
  type        = list(string)
  default     = ['test','test2']
}