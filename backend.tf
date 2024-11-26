terraform {
  cloud {
    organization = "tomitheninja"
    workspaces {
      project = "infra_tfe"
      name    = "terraform_tfe"
    }
  }
}
