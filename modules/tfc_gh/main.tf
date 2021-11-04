# This module builds both a GitHub repository from our Terraform template
# AND
# a Terraform Cloud Workspace that is VCS-integrated with the GitHub repository.

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.26.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
  token = var.gh_token
  owner = var.gh_organization
}

# Configure the Terraform Cloud Provider
provider "tfe" {
  hostname = var.tfc_hostname
  token    = var.tfc_token
}


# Create the repository in GitHub
resource "github_repository" "default" {
  name               = "mitlib-tf-${var.aws_ou}-${var.app_name}"
  description        = var.gh_description
  visibility         = var.gh_visibility
  gitignore_template = "Terraform"
  allow_rebase_merge = false
  auto_init          = true
  license_template   = "Apache License 2.0"
  template {
    owner      = var.gh_organization
    repository = "tf-template"
  }
}

# Create the workspace in Terraform Cloud that is linked to the GitHub repository
resource "tfe_workspace" "default" {
  for_each = toset(var.environments)

  organization = var.tfc_organization
  name         = "${var.aws_ou}-${var.app_name}-${each.key}"
  description  = var.tfc_description
  vcs_repo {
    identifier     = "${var.gh_organization}/${github_repository.default.name}"
    oauth_token_id = var.tfc_oauth_token_id
  }
  terraform_version   = var.tfc_version
  queue_all_runs      = false
  global_remote_state = true
  trigger_prefixes    = []
  tag_names           = [var.aws_ou, var.app_name, each.key, "tfcmgmt"]

  depends_on = [
    github_repository.default
  ]
}

# Put the set of initial variables and values in to the workspace
resource "tfe_variable" "ou" {
  for_each = toset(var.environments)

  key          = "ou"
  value        = var.aws_ou
  category     = "terraform"
  workspace_id = tfe_workspace.default[each.value].id
  description  = "The name of the MITLibraries AWS OU"

  depends_on = [
    tfe_workspace.default
  ]
}

resource "tfe_variable" "name" {
  for_each = toset(var.environments)

  key          = "name"
  value        = var.app_name
  category     = "terraform"
  workspace_id = tfe_workspace.default[each.value].id
  description  = "The name of the app/resource"

  depends_on = [
    tfe_workspace.default
  ]
}

resource "tfe_variable" "environment" {
  for_each = toset(var.environments)

  key          = "environment"
  value        = each.key
  category     = "terraform"
  workspace_id = tfe_workspace.default[each.value].id
  description  = "The name of the environment/workspace/stage"

  depends_on = [
    tfe_workspace.default
  ]
}
