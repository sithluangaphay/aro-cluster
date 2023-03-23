resource "azapi_update_resource" "update_aro" {
  type        = "Microsoft.RedHatOpenShift/openShiftClusters@2022-04-01"
  resource_id = "/subscriptions/############/resourceGroups/rg-openshifttest-lab-east-002/providers/Microsoft.RedHatOpenShift/OpenShiftClusters/aro"
  body = jsonencode({
    properties = {
      workerProfiles = [
        { name            ="testnewname"
          subnetId        ="/subscriptions/############/resourceGroups/rg-openshifttest-lab-east-002/providers/Microsoft.Network/virtualNetworks/vnet-aro-lab-east-002/subnets/arolab_worker_subnet002"
          vmSize           = "Standard_D8s_v3"
      
        }
      ]
      }
  })

  depends_on = [
    azapi_resource.arolab_cluster
  ]
}
