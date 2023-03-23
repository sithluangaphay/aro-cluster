terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
  
  
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">=1.0.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.33.0"
    }
  }  
  
  
  }

  

provider "azurerm" {
    features {}
}

