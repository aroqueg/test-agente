variable "name" {
  description = "Nombre de la cuenta de almacenamiento."
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos donde se desplegará la cuenta."
  type        = string
}

variable "location" {
  description = "Región de Azure donde se desplegará la cuenta."
  type        = string
}
