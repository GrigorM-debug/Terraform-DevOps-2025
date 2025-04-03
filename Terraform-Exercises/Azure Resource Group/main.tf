terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.25.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "ad394a49-0a97-4d33-ba74-83362255adf4"
}

provider "random" {
  # Configuration options
}

resource "random_integer" "priority" {
  min = 10000
  max = 99999
}

# Create a new resource group
resource "azurerm_resource_group" "arg" {
  name     = "TerraformResourceGroup${random_integer.priority.result}"
  location = "Italy North"
}
