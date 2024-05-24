resource "azurerm_resource_group" "group" {
  name     = "ntier"
  location = "eastus"
  tags = {
    createdBy   = "Terraform"
    Environment = "Dev"
  }
}
