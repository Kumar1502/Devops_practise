resource "azurerm_resource_group" "manual" {
  name     = var.resource_group_info.name
  location = var.resource_group_info.location
  tags = {
    createdBy   = var.resource_group_info.createdby
    Environment = var.resource_group_info.environment
  }
}
