#declare a resourcec group
resource "azurerm_resource_group" "group" {
  name     = "my_resource"
  location = "Centralindia"
  tags = {
    Environment = "staging"
    CreatedBy   = "Kumar"
  }

}
#declare a storage account
resource "azurerm_storage_account" "account" {
  account_replication_type = "GRS"
  account_tier             = "Standard"
  resource_group_name      = "my_resource"
  name                     = "mystorage0906s"
  location                 = "Centralindia"
  tags = {
    CreatedBy = "Kumar"
  }
  depends_on = [azurerm_resource_group.group]
}
