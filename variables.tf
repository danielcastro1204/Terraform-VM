variable "location" {
  description = "Region de Azure"
  type        = string
  default     = "eastus2"
}

variable "admin_username" {
  description = "Usuario administrador"
  type        = string
}

variable "admin_password" {
  description = "Contraseña administrador"
  type        = string
  sensitive   = true
}

