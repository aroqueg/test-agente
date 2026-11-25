variable "resource_group_name" {
  description = "Nombre del nuevo grupo de recursos."
  type        = string
}

variable "app_service_plan_name" {
  description = "Nombre del App Service Plan Linux compartido."
  type        = string
}

variable "app_service_plan_sku_name" {
  description = "SKU del App Service Plan."
  type        = string
}

variable "frontend_app_name" {
  description = "Nombre único de la aplicación web frontend Angular."
  type        = string
}

variable "backend_app_name" {
  description = "Nombre único de la aplicación web backend Java."
  type        = string
}

variable "java_version" {
  description = "Versión de Java para el App Service backend."
  type        = string
}

variable "java_container" {
  description = "Contenedor Java para el App Service backend."
  type        = string
}

variable "java_container_version" {
  description = "Versión del contenedor Java para el App Service backend."
  type        = string
}

variable "sql_server_name" {
  description = "Nombre globalmente único del servidor lógico Azure SQL."
  type        = string
}

variable "sql_server_version" {
  description = "Versión del servidor SQL requerida por el módulo (2.0 o 12.0)."
  type        = string

  validation {
    condition     = contains(["2.0", "12.0"], var.sql_server_version)
    error_message = "sql_server_version debe ser 2.0 o 12.0."
  }
}

variable "sql_administrator_login" {
  description = "Inicio de sesión de administrador del servidor Azure SQL."
  type        = string
  sensitive   = true
}

variable "sql_administrator_password" {
  description = "Contraseña de administrador del servidor Azure SQL. Se envía al módulo mediante su argumento write-only."
  type        = string
  sensitive   = true
}

variable "sql_database_name" {
  description = "Nombre de la base de datos Azure SQL."
  type        = string
}

variable "sql_database_sku_name" {
  description = "SKU de la base de datos Azure SQL serverless."
  type        = string
}

variable "sql_database_max_size_gb" {
  description = "Tamaño máximo de la base de datos en GB."
  type        = number
}

variable "sql_database_min_capacity" {
  description = "Capacidad mínima de la base de datos serverless."
  type        = number
}

variable "sql_database_auto_pause_delay_in_minutes" {
  description = "Minutos antes de la pausa automática de la base de datos serverless."
  type        = number
}

variable "backend_egress_ip_addresses" {
  description = "Direcciones IPv4 de salida del App Service backend que se permiten en el firewall de SQL."
  type        = list(string)

  validation {
    condition     = length(var.backend_egress_ip_addresses) > 0
    error_message = "Debe proporcionarse al menos una dirección IP de salida del backend para restringir el acceso público a SQL."
  }

  validation {
    condition     = length(distinct(var.backend_egress_ip_addresses)) == length(var.backend_egress_ip_addresses)
    error_message = "La lista de direcciones IP de salida del backend no debe contener duplicados."
  }
}
