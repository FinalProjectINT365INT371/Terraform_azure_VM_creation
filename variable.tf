variable "az_subscription_id" {
    type = string
}

variable "az_server_password" { 
    type = string
}

variable "resource_group_name_prefix" {
  default       = "rg"
  description   = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "resource_group_location" {
  default = "Southeast Asia"
  description   = "Location of the resource group."
}