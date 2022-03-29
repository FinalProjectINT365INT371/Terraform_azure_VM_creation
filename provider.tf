terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.0.2"
    }
  }
}

provider "azurerm" {
  subscription_id = var.az_subscription_id
  features {}
}

resource "azurerm_resource_group" "final_resource" {
  name = "Final_resource"
  location = "Southeast Asia"
}
