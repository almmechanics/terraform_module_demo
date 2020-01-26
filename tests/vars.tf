variable "location" {
  description = "Azure region to be deployed into."
  type        = string
}

variable "id" {
  description = "Unique ID for this configuration."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "usage" {
  description = "Human friendly tag for this use of this environment."
  type        = string
}