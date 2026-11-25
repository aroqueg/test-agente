locals {
  common_tags = merge(var.tags, {
    managed_by = "Terraform"
  })
}

resource "azurerm_service_plan" "this" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.app_service_plan_sku_name

  tags = local.common_tags
}

resource "azurerm_linux_web_app" "frontend" {
  name                = var.frontend_app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id

  https_only                    = true
  public_network_access_enabled = true
  virtual_network_subnet_id     = var.app_service_vnet_integration_subnet_id

  site_config {
    always_on           = true
    ftps_state          = "Disabled"
    http2_enabled       = true
    minimum_tls_version = "1.2"
    vnet_route_all_enabled = false

    application_stack {
      node_version = var.node_version
    }
  }

  app_settings = {
    BACKEND_BASE_URL = "https://${azurerm_linux_web_app.backend.default_hostname}"
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }

  tags = local.common_tags
}

resource "azurerm_linux_web_app" "backend" {
  name                = var.backend_app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id

  https_only                    = true
  public_network_access_enabled = true
  virtual_network_subnet_id     = var.app_service_vnet_integration_subnet_id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on           = true
    ftps_state          = "Disabled"
    http2_enabled       = true
    minimum_tls_version = "1.2"
    vnet_route_all_enabled = false

    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  app_settings = {
    SQL_CONNECTION_STRING = "Server=tcp:${azurerm_mssql_server.this.fully_qualified_domain_name},1433;Database=${azurerm_mssql_database.this.name};Encrypt=True;TrustServerCertificate=False;Authentication=Active Directory Managed Identity;"
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }

  tags = local.common_tags
}

resource "azurerm_mssql_server" "this" {
  name                = var.sql_server_name
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = "12.0"

  minimum_tls_version           = "1.2"
  public_network_access_enabled = false
  azuread_authentication_only  = true

  azuread_administrator {
    login_username = var.sql_entra_admin_login_username
    object_id      = var.sql_entra_admin_object_id
    tenant_id      = var.tenant_id
  }

  tags = local.common_tags
}

resource "azurerm_mssql_database" "this" {
  name      = var.sql_database_name
  server_id = azurerm_mssql_server.this.id

  sku_name                     = var.sql_database_sku_name
  max_size_gb                  = var.sql_database_max_size_gb
  min_capacity                 = var.sql_database_min_capacity
  auto_pause_delay_in_minutes  = var.sql_database_auto_pause_delay_in_minutes
  zone_redundant               = false
  read_scale                   = false

  short_term_retention_policy {
    retention_days = 7
  }

  tags = local.common_tags
}

resource "azurerm_private_endpoint" "sql" {
  name                = "${var.sql_server_name}-pe"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.sql_private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.sql_server_name}-sql"
    private_connection_resource_id = azurerm_mssql_server.this.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "sql-private-dns"
    private_dns_zone_ids = [var.sql_private_dns_zone_id]
  }

  tags = local.common_tags
}
