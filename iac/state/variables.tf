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

variable "github_repository" {
  type        = string
  default     = "PG14"
  description = "The name of the GitHub repository to target"
}

variable "github_organization" {
  type        = string
  default     = "piotrzajac"
  description = "The name of the GitHub organization to target"
}