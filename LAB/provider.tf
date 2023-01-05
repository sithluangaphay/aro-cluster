terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  tenant_id = "29686bf7-7e4e-4498-b5b8-fe4162035737"
  features {}
}
