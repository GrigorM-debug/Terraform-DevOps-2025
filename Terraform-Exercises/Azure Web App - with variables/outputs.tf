output "web_app_domain_url" {
  value = azurerm_linux_web_app.alwp.default_hostname
}