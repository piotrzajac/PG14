# Retrieve information about the currently authenticated user
data "github_user" "current" {
  username = ""
}

# Store secrets related to the Azure storage for the Terraform state in GitHub Actions
resource "github_actions_secret" "azure" {
  for_each = {
    STATE_CLIENT_ID       = azurerm_user_assigned_identity.msi.client_id
    STATE_TENANT_ID       = data.azurerm_client_config.current.tenant_id
    STATE_SUBSCRIPTION_ID = data.azurerm_client_config.current.subscription_id
  }
  repository      = var.github_repository
  secret_name     = each.key
  plaintext_value = each.value
}

# Create environments in the GitHub repository
resource "github_repository_environment" "environments" {
  count               = length(local.environments)
  environment         = local.environments[count.index]
  repository          = var.github_repository
  prevent_self_review = true
  reviewers {
    users = [data.github_user.current.id]
  }
}
