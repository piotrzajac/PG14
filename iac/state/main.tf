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
  msi_endpoint    = "http://169.254.169.254/metadata/identity/oauth2/v2.0/token"
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.project_name}-${local.area}"
  location = var.location
}