resource "azurerm_network_interface" "nic" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_allocation
    public_ip_address_id          = var.public_ip_id
  }
}

resource "azurerm_network_interface_security_group_association" "assoc" {
  count = var.create_nsg_association ? 1 : 0

  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.nsg_id
}