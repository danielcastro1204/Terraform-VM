variable "name" {
  description = "Nombre de la IP pública"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "allocation_method" {
  description = "Método de asignación (Static o Dynamic)"
  type        = string
  default     = "Static"
}

variable "sku" {
  description = "SKU de la IP pública"
  type        = string
  default     = "Standard"
}