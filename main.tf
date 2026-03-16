terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
module "resource_group" {
  source = "./modules/resource_group"

  name     = "rgdanielcastro"
  location = var.location
}

# Network
module "network" {
  source = "./modules/network"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  vnet_name        = "vnetdanielcastro"
  address_space    = ["10.0.0.0/16"]
  subnet_name      = "subnetdanielcastro"
  subnet_prefixes  = ["10.0.1.0/24"]
  nsg_name         = "nsgdanielcastro"
  security_rules = [
    {
      name                       = "ssh"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

# Public IP
module "public_ip" {
  source = "./modules/public_ip"

  name                = "pipdanielcastro"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# NIC
module "nic" {
  source = "./modules/nic"

  name                = "nicdanielcastro"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.network.subnet_id
  public_ip_id        = module.public_ip.id
  nsg_id              = module.network.nsg_id
  create_nsg_association = true   # <-- nuevo
}

# Virtual Machine
module "vm" {
  source = "./modules/vm"

  name                = "vmdanielcastro"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  size                = "Standard_D2s_v3"

  admin_username = var.admin_username
  admin_password = var.admin_password

  nic_id = module.nic.id

  image_publisher = "Canonical"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_sku       = "22_04-lts"
  image_version   = "latest"
}