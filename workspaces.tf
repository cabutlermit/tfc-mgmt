# This calls the tfc_gh module which will create 
#   one repo
#   as many workspaces as listed in `environments`
#   three default variable values in each workspace tracking ou, name, and environment.
# For each new app or shared resource that needs a GitHub repository, create a new module "" { } block

# App1
module "app1" {
  source             = "./modules/tfc_gh"
  aws_ou             = "workloads"
  app_name           = "app1"
  environments       = ["dev", "test", "stage"]
  tfc_organization   = "cabutler-private"
  tfc_description    = "The app1 workspace."
  tfc_token          = var.tfc_token
  tfc_oauth_token_id = var.tfc_oauth_token_id
  tfc_version        = var.tfc_version
  gh_organization    = "cabutlermit"
  gh_token           = var.gh_token
  gh_description     = "The app1 repository."
  gh_visibility      = "public"
}

# CREOS AWS Account core configuration
module "creos" {
  source             = "./modules/tfc_gh"
  aws_ou             = "research"
  app_name           = "creos"
  environments       = ["test"]
  tfc_organization   = "cabutler-private"
  tfc_description    = "The CREOS workspace."
  tfc_token          = var.tfc_token
  tfc_oauth_token_id = var.tfc_oauth_token_id
  tfc_version        = var.tfc_version
  gh_organization    = "cabutlermit"
  gh_token           = var.gh_token
  gh_description     = "The CREOS repository."
  gh_visibility      = "public"
}