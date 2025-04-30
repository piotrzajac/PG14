resource "azurerm_user_assigned_identity" "msi" {
  name                = "id-${local.project_name}-${local.area}"
  resource_group_name = azurerm_resource_group.managed_identity.name
  location            = azurerm_resource_group.managed_identity.location
}

resource "azurerm_role_assignment" "subscription_owner" {
  principal_id         = azurerm_user_assigned_identity.msi.principal_id
  principal_type       = "ServicePrincipal"
  role_definition_name = "Owner"
  scope                = data.azurerm_subscription.current.id
}

resource "azurerm_role_assignment" "state_blob_contributor" {
  principal_id         = azurerm_user_assigned_identity.msi.principal_id
  principal_type       = "ServicePrincipal"
  role_definition_name = "Storage Blob Data Contributor"
  scope                = azurerm_storage_account.tf_state_storage.id
}

# Create federated identity credentials for each environment
resource "azurerm_federated_identity_credential" "github_federated_credentials" {
  count               = length(local.environments)
  name                = "${var.github_organization}-${var.github_repository}-${local.environments[count.index]}"
  resource_group_name = azurerm_resource_group.managed_identity.name
  audience            = [local.default_audience_name]
  issuer              = local.github_issuer_url
  parent_id           = azurerm_user_assigned_identity.msi.id
  subject             = "repo:${var.github_organization}/${var.github_repository}:environment:${local.environments[count.index]}"
}
