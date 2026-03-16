variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
}

variable "vnet_name" {
  description = "Nombre de la red virtual"
  type        = string
}

variable "address_space" {
  description = "Espacio de direcciones de la VNet"
  type        = list(string)
}

variable "subnet_name" {
  description = "Nombre de la subred"
  type        = string
}

variable "subnet_prefixes" {
  description = "Prefijos de direcciones de la subred"
  type        = list(string)
}

variable "nsg_name" {
  description = "Nombre del grupo de seguridad de red"
  type        = string
}

variable "security_rules" {
  description = "Lista de reglas de seguridad"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}