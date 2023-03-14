resource "azurerm_virtual_network" "vnet" {
  for_each            = local.aro_rg_vnet
  name                = each.value.vnet_name
  address_space       = each.value.address_space
  location            = local.locations
  dns_servers         = local.dns_server
  resource_group_name = each.value.resource_group_name
  depends_on = [
    azurerm_resource_group.rg,
  ]
}

resource "azurerm_subnet" "main" {
  for_each             = local.aro_rg_vnet
  name                 = each.value.main_subnet_name
  address_prefixes     = each.value.main_subnet_cidr
  virtual_network_name = azurerm_virtual_network.vnet[each.key].name
  resource_group_name  = each.value.resource_group_name
   enforce_private_link_endpoint_network_policies = false
  enforce_private_link_service_network_policies  = false
  service_endpoints    = ["Microsoft.ContainerRegistry", "Microsoft.Storage"] 
 depends_on = [
    azurerm_resource_group.rg,
    azurerm_virtual_network.vnet
  ]
   lifecycle {
    ignore_changes = [
      enforce_private_link_service_network_policies,
      enforce_private_link_endpoint_network_policies
    ]
  }
}

resource "azurerm_subnet" "worker" {
  for_each             = local.aro_rg_vnet
  name                 = each.value.worker_subnet_name
  address_prefixes     = each.value.worker_subnet_cidr
  virtual_network_name = azurerm_virtual_network.vnet[each.key].name
  resource_group_name  = each.value.resource_group_name
  service_endpoints    = ["Microsoft.ContainerRegistry", "Microsoft.Storage"] 
  depends_on = [
    azurerm_resource_group.rg,
    azurerm_virtual_network.vnet
  ]
}