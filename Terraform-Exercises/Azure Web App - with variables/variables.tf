variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group name"
  type        = string
}

variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
}

variable "service_plan_name" {
  description = "Name of the service plan"
  type        = string
}

variable "service_plan_sku" {
  description = "SKU of the service plan"
  type        = string
}

variable "service_plan_os_type" {
  description = "Os type of the service plan"
  type        = string
}

variable "web_app_name" {
  description = "Web App name"
  type        = string
}

variable "web_app_node_version" {
  description = "Node version for the web app"
  type        = string
}

variable "repo_url" {
  description = "URL of the repository"
  type        = string
}

variable "repo_branch" {
  description = "Repo branch"
  type        = string
}