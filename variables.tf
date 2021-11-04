
variable "tfc_token" {
  description = "The user token for the Terraform Cloud automation account."
  type        = string
  sensitive   = true
}

variable "tfc_oauth_token_id" {
  description = "The OAuth token id in Terraform Cloud for VCS integration"
  type        = string
  sensitive   = true
}

variable "tfc_version" {
  description = "The version of Terraform to run in TfC"
  type        = string
}

# Information about GitHub
variable "gh_token" {
  description = "The GitHub user token for the special MIT Libraries user account in github.com/MITLibraries"
  type        = string
  sensitive   = true
}
