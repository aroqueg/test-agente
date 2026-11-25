module "storage_account" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.11.0"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
}
