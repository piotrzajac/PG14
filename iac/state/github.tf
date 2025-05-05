# Retrieve information about the currently authenticated user
data "github_user" "current" {
  username = ""
}

# Store secrets related to the Azure storage for the Terraform state in GitHub Actions
resource "github_actions_secret" "azure" {
  for_each = {
    TF_STATE_AZURE_CLIENT_ID       = azurerm_user_assigned_identity.msi.client_id
    TF_STATE_AZURE_TENANT_ID       = data.azurerm_client_config.current.tenant_id
    TF_STATE_AZURE_SUBSCRIPTION_ID = data.azurerm_client_config.current.subscription_id
  }
  repository      = var.github_repository
  secret_name     = each.key
  plaintext_value = each.value
}

resource "github_actions_variable" "backend_azure" {
  for_each = {
    TF_STATE_AZURE_RESOURCE_GROUP_NAME  = azurerm_resource_group.tf_state.name
    TF_STATE_AZURE_STORAGE_ACCOUNT_NAME = azurerm_storage_account.tf_state_storage.name
  }
  repository    = var.github_repository
  variable_name = each.key
  value         = each.value
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
