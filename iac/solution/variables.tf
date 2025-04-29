variable "tenant_id" {
  description = "The Azure tenant ID"
  type        = string
}

variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

variable "environment" {
  description = "The environment for all resources"
  type        = string
}

variable "location" {
  description = "The location for all resources"
  type        = string
  default     = "westeurope"
}