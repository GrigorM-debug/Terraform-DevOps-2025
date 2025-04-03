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
  subscription_id = var.subscription_id
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
  name     = "${var.resource_group_name}${random_integer.priority.result}"
  location = var.resource_group_location
}

# Create an App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = "${var.service_plan_name}${random_integer.priority.result}"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_resource_group.arg.location
  os_type             = var.service_plan_os_type
  sku_name            = var.service_plan_sku
}

# Create a Linux Web App
resource "azurerm_linux_web_app" "alwp" {
  name                = "${var.web_app_name}${random_integer.priority.result}"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_service_plan.asp.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      node_version = var.web_app_node_version
    }
    always_on = false
  }
}

#Deploy the source code from a GitHub repository
resource "azurerm_app_service_source_control" "apssc" {
  app_id                 = azurerm_linux_web_app.alwp.id
  repo_url               = var.repo_url
  branch                 = var.repo_branch
  use_manual_integration = true
}
