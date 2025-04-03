variable "subscription_id" {
  type = string
  description = "Azure Subscription Id"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "resource_group_location" {
  type        = string
  description = "The location of the resource group"
}

variable "sql_server_name" {
  type        = string
  description = "The name of the Sql Server"
}

variable "sql_server_version" {
  type        = string
  description = "The version of the server"
}

variable "sql_server_admin_username" {
  type        = string
  description = "The admin username"
}

variable "sql_server_admin_password" {
  type        = string
  description = "The admin password"
}

variable "database_name" {
  type        = string
  description = "The name of the database"
}

variable "database_collation" {
  type        = string
  description = "Database collation"
}

variable "database_sku_name" {
  type        = string
  description = "Datase Sku name"
}

variable "database_license_type" {
  type        = string
  description = "Database license type"
}

variable "database_zone_redundant" {
  type        = bool
  description = "Database zone redundant"
}

variable "firewall_rule_start_ip_address" {
  type        = string
  description = "Firewall rule starter ip address"
}

variable "firewall_rule_end_ip_address" {
  type        = string
  description = "Firewall rule end ip address"
}

variable "firewall_rule_name" {
  type        = string
  description = "The name of the firewall rule"
}

variable "azurerm_service_plan_name" {
  type        = string
  description = "Azure Web Service Plan name"
}

variable "azurerm_service_plan_os_type" {
  type        = string
  description = "Azure Web Service Plan os type"
}

variable "azurerm_service_plan_sku_name" {
  type        = string
  description = "Azure Web Service Sku name"
}

variable "azurerm_linux_web_app_name" {
  type        = string
  description = "Azure Web App Service name"
}

variable "dotnet_verion" {
  type        = string
  description = "The version of the .net"
}

variable "connection_string_type" {
  type        = string
  description = "The type of the connection string"
}

variable "connection_string_name" {
  type        = string
  description = "The name of the connection string"
}

variable "repo_branch" {
  type        = string
  description = "repo branch"
}

variable "repo_url" {
  type        = string
  description = "The repo url"
}
