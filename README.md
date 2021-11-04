# Terraform Cloud and GitHub.com Management

Manage GitHub repositories and Terraform Cloud workspaces.

## Dependencies

### GitHub Template

We make use of a template in GitHub for all of our Terraform code moving forward. The template includes the following.

* a default `main` branch with simple branch protection (per the DevDocs)
* an `main.tf` file
* a `versions.tf` file with a simple block of code setting "~> 1.0" version constraint on Terraform
* a `.gitignore` file from the GitHub Terraform template
* a `variables.tf` file with four variable definitions
  * `mitlib` ("The shortname name of our MITLibraries Organization")
  * `ou` = ("The name of the AWS OU this repo is linked to")
  * `name` = ("The name of the app/resource this repo builds")
  * `environment` = ("The name of the environment/stage/workspace (e.g., `stage`, `prod`, `dev`)")

### Terraform Cloud Workspace VCS Integration

The VCS integration between the Terraform Cloud Organization and our GitHub Organization must be configured and the OAuth Token ID must be captured as an input into this code.

## What is created

The heavy lifting is in an embedded module named `tfc_gh`. In the main section of code, each call to that module will create the following resources

* In GitHub
  * a single repository
* In Terraform Cloud
  * one workspace per "environment" (e.g., `stage` or `prod` or `dev`)
  * VCS integration between the workspace and the repository
  * initial values for the three variables without devaults (`ou`, `name`, `environment`)

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| app1 | ./modules/tfc_gh | n/a |
| creos | ./modules/tfc_gh | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gh\_token | The GitHub user token for the special MIT Libraries user account in github.com/MITLibraries | `string` | n/a | yes |
| tfc\_oauth\_token\_id | The OAuth token id in Terraform Cloud for VCS integration | `string` | n/a | yes |
| tfc\_token | The user token for the Terraform Cloud automation account. | `string` | n/a | yes |
| tfc\_version | The version of Terraform to run in TfC | `string` | n/a | yes |

## Outputs

No outputs.
