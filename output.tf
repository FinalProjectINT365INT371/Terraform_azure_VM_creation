output "resource_group_name" {
  value = azurerm_resource_group.final_resource.name
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.vm_eduvalor.public_ip_address
}

output "tls_private_key" {
  value     = tls_private_key.vm_key.private_key_pem
  sensitive = true
}