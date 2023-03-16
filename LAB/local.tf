locals {
  aro_rg_vnet = {
    "rg-openshifttest-lab-east-002" = {
      resource_group_name = "rg-openshifttest-lab-east-002"
      vnet_name           = "vnet-aro-lab-east-002"
      address_space       = ["10.246.0.0/21"]
      main_subnet_name    = "arolab_main_subnet002"
      main_subnet_cidr    = ["10.246.0.0/24"]
      worker_subnet_name  = "arolab_worker_subnet002"
      worker_subnet_cidr  = ["10.246.1.0/24"]
      domains             = "lab"
      aro_names           = "aro"
      spn_ids             = "9b503cff-d35c-4c61-9da3-6d7691998190"
    },
  #  "rg-openshifttest-lab-east-003" = {
  #    resource_group_name = "rg-openshifttest-lab-east-003"
  #   vnet_name           = "vnet-aro-lab-east-003"
  #    address_space       = ["10.247.0.0/21"]
  #    main_subnet_name    = "arolab_main_subnet003"
  #    main_subnet_cidr    = ["10.247.0.0/24"]
  #    worker_subnet_name  = "arolab_worker_subnet003"
  #    worker_subnet_cidr  = ["10.247.1.0/24"]
  #    domains             = "lab2"
  #    aro_names           = "aro2"
  #  }
  }


  locations = "eastus"
  dns_server = ["10.240.17.4", "10.240.17.5"]
  worker_node_vm_size       = "Standard_D4s_v3"
  master_node_vm_size       = "Standard_D8s_v3"
  worker_profile_name       = "worker"
  worker_node_vm_disk_size  = 128
  worker_node_count         = 3
  pod_cidr                  = "10.100.0.0/14"
  service_cidr              = "172.30.0.0/16"
  api_server_visibility     = "Private"
  ingress_profile_name      = "default"
  ingress_visibility        = "Private"
  fips_validated_modules    = "Disabled"
  master_encryption_at_host = "Disabled"
  worker_encryption_at_host = "Disabled"
}