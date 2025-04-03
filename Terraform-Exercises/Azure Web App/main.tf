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
  name     = "ContactBookRG${random_integer.priority.result}"
  location = "Italy North"
}

# Create an App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = "contact-book-${random_integer.priority.result}"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_resource_group.arg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

# Create a Linux Web App
resource "azurerm_linux_web_app" "alwp" {
  name                = "contact-book-${random_integer.priority.result}"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_service_plan.asp.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      node_version = "16-lts"
    }
    always_on = false
  }
}

#Deploy the source code from a GitHub repository
resource "azurerm_app_service_source_control" "apssc" {
  app_id                 = azurerm_linux_web_app.alwp.id
  repo_url               = "https://github.com/nakov/ContactBook"
  branch                 = "master"
  use_manual_integration = true
}
