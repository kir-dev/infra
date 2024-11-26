terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.60.1"
    }
  }
}

provider "tfe" {
  # Configuration options
}

resource "tfe_project" "environment" {
  for_each = local.products

  name         = each.key
  organization = var.organization_name
}

resource "tfe_workspace" "product_workspace" {
  depends_on = [tfe_project.environment]
  for_each = merge([
  for environment, products in local.products : { for product, product_conf in products : product => environment }]...)


  name         = each.key
  project_id   = tfe_project.environment[each.value].id
  organization = var.organization_name
  description  = local.products[each.value][each.key]["description"]
  vcs_repo {
    github_app_installation_id = data.tfe_github_app_installation.this.id
    identifier                 = "${var.github_organization_name}/${var.github_repository_name}"
  }
}

resource "tfe_workspace_settings" "product_workspace_settings" {
  for_each = merge([
  for environment, products in local.products : { for product, product_conf in products : product => environment }]...)

  workspace_id   = tfe_workspace.product_workspace[each.key].id
  execution_mode = "remote"
}
