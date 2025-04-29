variable "tenant_id" {
  description = "The tenant ID"
  type        = string
}

variable "subscription_id" {
  description = "The subscription ID"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "westeurope"
}