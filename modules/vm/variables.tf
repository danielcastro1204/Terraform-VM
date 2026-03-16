variable "name" {
  description = "Nombre de la VM"
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

variable "size" {
  description = "Tamaño de la VM"
  type        = string
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

variable "nic_id" {
  description = "ID de la interfaz de red"
  type        = string
}

variable "os_disk_caching" {
  description = "Tipo de caché del disco del SO"
  type        = string
  default     = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  description = "Tipo de cuenta de almacenamiento del disco del SO"
  type        = string
  default     = "Standard_LRS"
}

variable "image_publisher" {
  description = "Publisher de la imagen"
  type        = string
}

variable "image_offer" {
  description = "Offer de la imagen"
  type        = string
}

variable "image_sku" {
  description = "SKU de la imagen"
  type        = string
}

variable "image_version" {
  description = "Versión de la imagen"
  type        = string
  default     = "latest"
}