resource "azurerm_storage_account" "tf_state_storage" {
  name                     = "st${local.project_name}${local.area}"
  resource_group_name      = azurerm_resource_group.tf_state.name
  location                 = azurerm_resource_group.tf_state.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  count                 = length(local.environments)
  name                  = "sc-${local.project_name}-${local.environments[count.index]}-tf-state"
  storage_account_id    = azurerm_storage_account.tf_state_storage.id
  container_access_type = "private"
}