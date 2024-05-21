terraform {
  #This is about provider information
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.100.0"
    }
  }

  #This is about terraform information
  required_version = "~>1.8.0"

}

#This block is for the azure provider which uses for cli authentication
provider "azurerm" {
  features {

  }

}
