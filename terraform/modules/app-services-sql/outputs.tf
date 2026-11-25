output "app_service_plan_id" {
  description = "ID del App Service Plan compartido."
  value       = azurerm_service_plan.this.id
}

output "frontend_app_id" {
  description = "ID del App Service del frontend."
  value       = azurerm_linux_web_app.frontend.id
}

output "frontend_default_hostname" {
  description = "Hostname HTTPS predeterminado del frontend."
  value       = azurerm_linux_web_app.frontend.default_hostname
}

output "backend_app_id" {
  description = "ID del App Service del backend."
  value       = azurerm_linux_web_app.backend.id
}

output "backend_default_hostname" {
  description = "Hostname HTTPS predeterminado del backend."
  value       = azurerm_linux_web_app.backend.default_hostname
}

output "backend_managed_identity_principal_id" {
  description = "Principal ID de la Managed Identity del backend; se utiliza para conceder acceso a la base de datos."
  value       = azurerm_linux_web_app.backend.identity[0].principal_id
}

output "sql_server_id" {
  description = "ID del servidor lógico Azure SQL."
  value       = azurerm_mssql_server.this.id
}

output "sql_server_fqdn" {
  description = "FQDN del servidor lógico Azure SQL."
  value       = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "sql_database_name" {
  description = "Nombre de la Azure SQL Database."
  value       = azurerm_mssql_database.this.name
}

output "sql_private_endpoint_id" {
  description = "ID del Private Endpoint de Azure SQL."
  value       = azurerm_private_endpoint.sql.id
}
