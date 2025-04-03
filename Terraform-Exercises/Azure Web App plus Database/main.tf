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
  features {
  }
  subscription_id = var.subscription_id
}

provider "random" {
  # Configuration options
}

resource "random_integer" "random" {
  min = 10000
  max = 99999
}

# Resource Group
resource "azurerm_resource_group" "arg" {
  name     = "${var.resource_group_name}-${random_integer.random.result}"
  location = var.resource_group_location
}

# Sql server
resource "azurerm_mssql_server" "azms" {
  name                         = "${var.sql_server_name}-${random_integer.random.result}"
  resource_group_name          = azurerm_resource_group.arg.name
  location                     = azurerm_resource_group.arg.location
  version                      = var.sql_server_version
  administrator_login          = var.sql_server_admin_username
  administrator_login_password = var.sql_server_admin_password
}

# Firewall rule
resource "azurerm_mssql_firewall_rule" "azmslfr" {
  name             = var.firewall_rule_name
  server_id        = azurerm_mssql_server.azms.id
  start_ip_address = var.firewall_rule_start_ip_address
  end_ip_address   = var.firewall_rule_end_ip_address
}

# Sql database
resource "azurerm_mssql_database" "azmsd" {
  name           = "${var.database_name}${random_integer.random.result}"
  server_id      = azurerm_mssql_server.azms.id
  collation      = var.database_collation
  license_type   = var.database_license_type
  sku_name       = var.database_sku_name
  zone_redundant = var.database_zone_redundant
}

# Azure Web App Service plan
resource "azurerm_service_plan" "azsp" {
  name                = "${var.azurerm_service_plan_name}-${random_integer.random.result}"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_resource_group.arg.location
  os_type             = var.azurerm_service_plan_os_type
  sku_name            = var.azurerm_service_plan_sku_name
}

# Azure Web App Service
resource "azurerm_linux_web_app" "azlwp" {
  name                = "${var.azurerm_linux_web_app_name}-${random_integer.random.result}"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_service_plan.azsp.location
  service_plan_id     = azurerm_service_plan.azsp.id

  site_config {
    application_stack {
      dotnet_version = var.dotnet_verion
    }
  }

  connection_string {
    value = "Data Source=tcp:${azurerm_mssql_server.azms.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.azmsd.name};User ID=${azurerm_mssql_server.azms.administrator_login};Password=${azurerm_mssql_server.azms.administrator_login_password};Trusted_Connection=False; MultipleActiveResultSets=True;"
    type  = var.connection_string_type
    name  = var.connection_string_name
  }
}

# Source Control 
resource "azurerm_app_service_source_control" "azapssc" {
  app_id   = azurerm_linux_web_app.azlwp.id
  repo_url = var.repo_url
  branch   = var.repo_branch
  use_manual_integration = false
}