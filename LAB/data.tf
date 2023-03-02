data "azurerm_client_config" "current" {
}

data "azuread_service_principal" "rh_id" {
  display_name = "Azure Red Hat OpenShift RP"
}
