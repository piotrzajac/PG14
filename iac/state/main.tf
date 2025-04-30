data "azurerm_client_config" "current" {
}

data "azurerm_subscription" "current" {
}

resource "azurerm_resource_group" "tf_state" {
  name     = "rg-${local.project_name}-tf-state"
  location = var.location
}

resource "azurerm_resource_group" "managed_identity" {
  name     = "rg-${local.project_name}-managed-identity"
  location = var.location
}
