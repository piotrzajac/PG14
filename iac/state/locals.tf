locals {
  project_name          = "pg14"
  area                  = "cicd"
  environments          = ["dev", "test", "prod"]
  default_audience_name = "api://AzureADTokenExchange"
  github_issuer_url     = "https://token.actions.githubusercontent.com"
}