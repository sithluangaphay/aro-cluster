resource "azuread_application" "app" {
  for_each     = local.aro_rg_vnet
  display_name = "aro-sp-${each.value.resource_group_name}"
  depends_on = [
    azurerm_resource_group.rgspn
  #  azurerm_key_vault.spnkeyvault
  ]
}

resource "azuread_service_principal" "service_principal" {
  for_each       = azuread_application.app
  application_id = each.value.application_id
  depends_on = [
    azurerm_resource_group.rgspn
  ]
}


resource "azuread_service_principal_password" "azuread_sp_password" {
  for_each       = azuread_application.app
      service_principal_id = azuread_service_principal.service_principal[each.key].object_id
}