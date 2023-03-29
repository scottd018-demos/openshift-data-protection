variable "cluster_name" {
  description = "Name of the Cluster"
  type        = string
  default     = "dscott"
}

# this can be obtained via rosa describe cluster -c <cluster_name>
variable "oidc_url" {
  description = "URL of OIDC provider"
  type        = string
}
