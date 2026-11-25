module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.5.0"

  name     = var.resource_group_name
  location = "spaincentral"
}

module "app_service_plan" {
  source  = "Azure/avm-res-web-serverfarm/azurerm"
  version = "2.1.0"

  name       = var.app_service_plan_name
  parent_id  = module.resource_group.resource_id
  location   = "spaincentral"
  os_type    = "Linux"
  sku_name   = var.app_service_plan_sku_name
  worker_count = 1
}

module "frontend" {
  source  = "Azure/avm-res-web-site/azurerm"
  version = "0.25.0"

  name                = var.frontend_app_name
  parent_id           = module.resource_group.resource_id
  location            = "spaincentral"
  service_plan_resource_id = module.app_service_plan.resource_id
  os_type             = "Linux"
  public_network_access_enabled = true

  site_config = {
    default_documents = ["index.html"]
  }
}

module "backend" {
  source  = "Azure/avm-res-web-site/azurerm"
  version = "0.25.0"

  name                = var.backend_app_name
  parent_id           = module.resource_group.resource_id
  location            = "spaincentral"
  service_plan_resource_id = module.app_service_plan.resource_id
  os_type             = "Linux"
  public_network_access_enabled = true

  site_config = {
    application_stack = {
      java = {
        java_version           = var.java_version
        java_container         = var.java_container
        java_container_version = var.java_container_version
      }
    }
  }
}

module "sql_server" {
  source  = "Azure/avm-res-sql-server/azurerm"
  version = "0.3.0"

  name                = var.sql_server_name
  resource_group_name = module.resource_group.name
  location            = "spaincentral"
  server_version      = var.sql_server_version

  administrator_login                  = var.sql_administrator_login
  administrator_login_password_wo      = var.sql_administrator_password
  administrator_login_password_wo_version = 1

  public_network_access_enabled = true

  databases = {
    application = {
      name                        = var.sql_database_name
      sku_name                    = var.sql_database_sku_name
      max_size_gb                 = var.sql_database_max_size_gb
      min_capacity                = var.sql_database_min_capacity
      auto_pause_delay_in_minutes = var.sql_database_auto_pause_delay_in_minutes
    }
  }

  firewall_rules = {
    for ip in var.backend_egress_ip_addresses : replace(ip, ".", "-") => {
      start_ip_address = ip
      end_ip_address   = ip
    }
  }
}
