variable "name" {
  description = "Nombre de la NIC"
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

variable "subnet_id" {
  description = "ID de la subred"
  type        = string
}

variable "public_ip_id" {
  description = "ID de la IP pública (opcional)"
  type        = string
  default     = null
}

variable "private_ip_allocation" {
  description = "Método de asignación de IP privada"
  type        = string
  default     = "Dynamic"
}

variable "nsg_id" {
  description = "ID del NSG a asociar (opcional)"
  type        = string
  default     = null
}

variable "create_nsg_association" {
  description = "Crear la asociación entre NIC y NSG"
  type        = bool
  default     = false
}