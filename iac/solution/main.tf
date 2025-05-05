resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.project_name}-${var.environment}"
  location = var.location
}