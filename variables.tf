variable "location" {
  description = "Región de Azure"
  type        = string
  default     = "eastus2"
}

variable "admin_username" {
  description = "Usuario administrador"
  type        = string
}

variable "admin_password" {
  description = "Contraseña del administrador"
  type        = string
  sensitive   = true
}