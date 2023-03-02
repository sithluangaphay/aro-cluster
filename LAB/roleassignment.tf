resource "azurerm_role_assignment" "arolab_cluster_service_principal_network_contributor" {
  for_each             = local.aro_rg_vnet
  scope                = azurerm_virtual_network.vnet[each.key].id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.service_principal[each.key].object_id
  skip_service_principal_aad_check = true
  depends_on = [
    azurerm_resource_group.rg,
    azurerm_subnet.main,
    azurerm_subnet.worker,
    azurerm_virtual_network.vnet,
    azuread_service_principal.service_principal
  ]
}

resource "azurerm_role_assignment" "arolab_resource_group_service_principal_user_access_admin" {
  for_each             = local.aro_rg_vnet
  scope                = azurerm_resource_group.rg[each.key].id
  role_definition_name = "User Access Administrator"
  principal_id         = azuread_service_principal.service_principal[each.key].object_id
  skip_service_principal_aad_check = true
  depends_on = [
    azurerm_resource_group.rg,
    azurerm_subnet.main,
    azurerm_subnet.worker,
    azurerm_virtual_network.vnet,
    azuread_service_principal.service_principal
  ]
}

resource "azurerm_role_assignment" "arolab_resource_group_service_principal_contributor" {
  for_each             = local.aro_rg_vnet
  scope                = azurerm_resource_group.rg[each.key].id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.service_principal[each.key].object_id
  skip_service_principal_aad_check = true
  depends_on = [
    azurerm_resource_group.rg,
    azurerm_subnet.main,
    azurerm_subnet.worker,
    azurerm_virtual_network.vnet,
    azuread_service_principal.service_principal
  ]
}

resource "azurerm_role_assignment" "arolab_resource_provider_service_principal_network_contributor" {
  for_each             = local.aro_rg_vnet
  scope                = azurerm_virtual_network.vnet[each.key].id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_service_principal.rh_id.object_id
  #az ad sp list --display-name "Azure Red Hat OpenShift RP" --query [0].id -o tsv
  skip_service_principal_aad_check = true
  depends_on = [
    azurerm_resource_group.rg,
    azurerm_subnet.main,
    azurerm_subnet.worker,
    azurerm_virtual_network.vnet,
    azuread_service_principal.service_principal
  ]
}