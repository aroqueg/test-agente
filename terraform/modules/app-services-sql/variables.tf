variable "resource_group_name" {
  description = "Resource Group existente dedicado a la aplicación."
  type        = string
}

variable "location" {
  description = "Región de Azure de los recursos, por ejemplo Spain Central."
  type        = string
}

variable "tags" {
  description = "Etiquetas aplicadas a los recursos."
  type        = map(string)
  default     = {}
}

variable "app_service_plan_name" {
  description = "Nombre único dentro del Resource Group para el App Service Plan."
  type        = string
}

variable "frontend_app_name" {
  description = "Nombre globalmente único del App Service Linux para el frontend Node.js."
  type        = string

  validation {
    condition     = length(var.frontend_app_name) >= 2 && length(var.frontend_app_name) <= 60 && can(regex("^[A-Za-z0-9-]+$", var.frontend_app_name))
    error_message = "El nombre del frontend debe tener entre 2 y 60 caracteres y contener solo letras, números y guiones."
  }
}

variable "backend_app_name" {
  description = "Nombre globalmente único del App Service Linux para el backend .NET."
  type        = string

  validation {
    condition     = length(var.backend_app_name) >= 2 && length(var.backend_app_name) <= 60 && can(regex("^[A-Za-z0-9-]+$", var.backend_app_name))
    error_message = "El nombre del backend debe tener entre 2 y 60 caracteres y contener solo letras, números y guiones."
  }
}

variable "app_service_plan_sku_name" {
  description = "SKU del plan compartido. Standard permite integración regional con VNet; un solo worker no proporciona alta disponibilidad."
  type        = string
  default     = "S1"
}

variable "node_version" {
  description = "Versión del runtime Node.js del frontend, en formato admitido por App Service, por ejemplo 20-lts."
  type        = string
  default     = "20-lts"
}

variable "dotnet_version" {
  description = "Versión del runtime .NET del backend, en formato admitido por App Service, por ejemplo 8.0."
  type        = string
  default     = "8.0"
}

variable "app_service_vnet_integration_subnet_id" {
  description = "ID de una subred existente del spoke, delegada a Microsoft.Web/serverFarms y dimensionada para App Service VNet Integration."
  type        = string
}

variable "sql_server_name" {
  description = "Nombre globalmente único del servidor lógico Azure SQL. Debe contener entre 1 y 63 caracteres en minúsculas, números o guiones."
  type        = string

  validation {
    condition     = length(var.sql_server_name) >= 1 && length(var.sql_server_name) <= 63 && can(regex("^[a-z0-9]([a-z0-9-]*[a-z0-9])?$", var.sql_server_name))
    error_message = "El nombre del servidor SQL debe tener entre 1 y 63 caracteres, usar minúsculas, números o guiones, y no empezar ni terminar con guion."
  }
}

variable "sql_database_name" {
  description = "Nombre de la Azure SQL Database."
  type        = string
  default     = "application"
}

variable "sql_database_sku_name" {
  description = "SKU de Azure SQL Database. Por ejemplo, GP_S_Gen5_1 para General Purpose serverless si está disponible en la región elegida."
  type        = string
}

variable "sql_database_max_size_gb" {
  description = "Tamaño máximo de la base de datos, en GB."
  type        = number
  default     = 32

  validation {
    condition     = var.sql_database_max_size_gb > 0
    error_message = "El tamaño máximo de la base de datos debe ser mayor que cero."
  }
}

variable "sql_database_min_capacity" {
  description = "Capacidad mínima en vCores para un SKU serverless. Usa null si el SKU elegido no es serverless."
  type        = number
  default     = 0.5
  nullable    = true
}

variable "sql_database_auto_pause_delay_in_minutes" {
  description = "Minutos de inactividad antes de pausar automáticamente una base serverless. Usa null si el SKU elegido no admite auto-pause."
  type        = number
  default     = 60
  nullable    = true
}

variable "sql_entra_admin_login_username" {
  description = "Nombre visible del grupo o usuario de Microsoft Entra configurado como administrador de Azure SQL."
  type        = string
}

variable "sql_entra_admin_object_id" {
  description = "Object ID del grupo o usuario de Microsoft Entra administrador de Azure SQL."
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID de Microsoft Entra."
  type        = string
}

variable "sql_private_endpoint_subnet_id" {
  description = "ID de una subred existente del spoke para Private Endpoints, separada de la subred de App Service Integration."
  type        = string
}

variable "sql_private_dns_zone_id" {
  description = "ID de la Private DNS Zone existente privatelink.database.windows.net."
  type        = string
}
