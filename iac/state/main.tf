terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.2.0"
    }
  }
}

provider "azurerm" {
  use_msi         = true
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.project_name}-${local.area}"
  location = var.location
}