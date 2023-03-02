resource "azurerm_resource_group" "rg" {
  for_each = local.aro_rg_vnet
  name     = each.value.resource_group_name
  location = local.locations
}
resource "azurerm_resource_group" "rgspn" {
  #make the name into a variable later
  name     = "rgspnkey"
  location = local.locations
}