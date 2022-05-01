resource "random_pet" "rg-name" {
  prefix    = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "final_resource" {
  name = random_pet.rg-name.id
  location = var.resource_group_location
}