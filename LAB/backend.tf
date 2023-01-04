terraform {
  backend "azurerm" {
    resource_group_name  = "cloud-shell-storage-eastus"
    storage_account_name = "cs2100320025a643c18"
    container_name       = "terraformstate"
    key                  = "test.state"
  }
}
