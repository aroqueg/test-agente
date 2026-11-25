variable "name" {
  description = "Nombre de la Azure Static Web App."
  type        = string
  default     = "static-frontend"
}

variable "location" {
  description = "Región de Azure donde se desplegará la Static Web App."
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos existente donde se desplegará la Static Web App."
  type        = string
}
