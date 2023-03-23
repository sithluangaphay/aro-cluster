resource "azapi_resource" "arolab_cluster" {
  for_each  = local.aro_rg_vnet
  name      = each.value.aro_names
  location  = local.locations
  parent_id = azurerm_resource_group.rg[each.key].id
  type      = "Microsoft.RedHatOpenShift/openShiftClusters@2022-04-01"
  depends_on = [
    azurerm_resource_group.rg,
    azurerm_subnet.main,
    azurerm_subnet.worker,
    azurerm_virtual_network.vnet,
    azuread_service_principal.service_principal
    #adding azurerm role assignment doesn't work
    #azurerm_role_assignment.arolab_resource_provider_service_principal_network_contributor
  ]

  timeouts {
    create = "100m"
    read   = "20m"
  }

  body = jsonencode({
    properties = {
      clusterProfile = {
        domain               = each.value.domains 
       fipsValidatedModules = local.fips_validated_modules
        resourceGroupId      = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${each.value.domains}-${each.value.aro_names}"
        #resourceGroupId      = local.resource_group_id
      }
      networkProfile = {
        podCidr     = local.pod_cidr
        serviceCidr = local.service_cidr
      }
      servicePrincipalProfile = {
        clientId     = azuread_service_principal.service_principal[each.key].application_id
        #clientId     = each.value.spn_ids
        clientSecret = azuread_service_principal_password.azuread_sp_password[each.key].value
      }
      masterProfile = {
        vmSize           = local.master_node_vm_size
        subnetId         = azurerm_subnet.main[each.key].id
        encryptionAtHost = local.master_encryption_at_host
      }
      workerProfiles = [
        {
          name             = local.worker_profile_name
          vmSize           = local.worker_node_vm_size
          diskSizeGB       = local.worker_node_vm_disk_size
          subnetId         = azurerm_subnet.worker[each.key].id
          count            = local.worker_node_count
          encryptionAtHost = local.worker_encryption_at_host
        }
      ]
      apiserverProfile = {
        visibility = local.api_server_visibility
      }
      ingressProfiles = [
        {
          name       = local.ingress_profile_name
          visibility = local.ingress_visibility
        }
      ]
    }
  })

  lifecycle {
    ignore_changes = [
      
      body
    ]
  }
}
