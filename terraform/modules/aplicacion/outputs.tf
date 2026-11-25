output "resource_group_id" {
  description = "ID del grupo de recursos creado."
  value       = module.resource_group.resource_id
}

output "frontend_hostname" {
  description = "Hostname predeterminado del frontend."
  value       = module.frontend.resource_uri
}

output "backend_hostname" {
  description = "Hostname predeterminado del backend."
  value       = module.backend.resource_uri
}

output "sql_server_id" {
  description = "ID del servidor lógico Azure SQL."
  value       = module.sql_server.resource_id
}

output "sql_database" {
  description = "Base de datos creada por el módulo Azure SQL."
  value       = module.sql_server.resource_databases["application"]
}
