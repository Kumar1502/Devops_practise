terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.104.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraformstate"
    storage_account_name = "ltbackendstoragemay"
    container_name       = "state"
    key                  = "exaple.tfstate"

  }
}

provider "azurerm" {
  features {

  }
}