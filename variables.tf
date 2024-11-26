variable "organization_name" {
  type    = string
  default = "tomitheninja"
}

variable "github_app_installation_id" {
  type        = number
  description = "GitHub App installation ID"
}

variable "github_organization_name" {
  type        = string
  description = "GitHub organization name"
}

variable "github_repository_name" {
  type        = string
  default     = "infra"
  description = "GitHub repository name without the organization"
}