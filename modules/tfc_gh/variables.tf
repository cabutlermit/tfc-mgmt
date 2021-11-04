# Variable inputs for repo & workspace settings
variable "aws_ou" {
  description = "The name of the AWS OU the repo builds resources in. E.g., `workloads` or `security` or `sandbox`."
  type        = string
}

variable "app_name" {
  description = "The name of the app stack or shared resource. E.g., `app1` or `networking` or `antivirus`."
  type        = string
}

variable "environments" {
  description = "The list of environments for this repo. E.g., `dev` or `stage` or `prod`."
  type        = list(string)
}


# Information about Terraform Cloud
variable "tfc_hostname" {
  description = "The hostname for Terraform Cloud"
  type        = string
  default     = "app.terraform.io"
}

variable "tfc_organization" {
  description = "The name of the TfC Organization where workspaces will be created"
  type        = string
  default     = "MITLibraries"
}

variable "tfc_description" {
  description = "The description of the Terraform Cloud Workspace."
  type        = string
}

variable "tfc_token" {
  description = "The user token for the special MIT Libraries user account (that must exist in each organization)"
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

variable "gh_organization" {
  description = "The name of the GitHub Organization where all the repos will live"
  type        = string
}

variable "gh_description" {
  description = "The description of the GitHub repository."
  type        = string
}

variable "gh_visibility" {
  description = "The public/private visibility of the repo in our GitHub organization."
  type        = string
  default     = "public"
}

