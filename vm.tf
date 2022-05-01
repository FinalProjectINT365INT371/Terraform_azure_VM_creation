resource "azurerm_network_interface" "eduvalor_interface_ntw" {
  name                = "az_interface_ntw"
  location            = azurerm_resource_group.final_resource.location
  resource_group_name = azurerm_resource_group.final_resource.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_internalA.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "tls_private_key" "vm_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}
resource "azurerm_linux_virtual_machine" "vm_eduvalor" {
  name                = "eduvalor-machine"
  resource_group_name = azurerm_resource_group.final_resource.name
  location            = azurerm_resource_group.final_resource.location
  size                = "Standard_B2s"
  admin_username      = "eduvalor371"
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.eduvalor_interface_ntw.id,
  ]

  admin_ssh_key {
    username   = "eduvalor371"
    public_key = tls_private_key.vm_key.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}