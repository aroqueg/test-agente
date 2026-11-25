module "static_web_app" {
  source  = "Azure/avm-res-web-staticsite/azurerm"
  version = "0.7.0"

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  enable_telemetry = false
}
