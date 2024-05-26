
# create virtual machine scale set
resource "azurerm_linux_virtual_machine_scale_set" "preschool" {
  name                = "preschool-vmss"
  location            = azurerm_resource_group.ntierlb.location
  resource_group_name = azurerm_resource_group.ntierlb.name
  network_interface {
    name    = "preschool-nic"
    primary = true
    ip_configuration {
      name                                   = "internal"
      subnet_id                              = azurerm_subnet.public[0].id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.preschool.id]
    }

  }
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"

  }
  admin_username                  = "Dell"
  admin_password                  = "qualitythought@1234"
  upgrade_mode                    = "Manual"
  disable_password_authentication = false
  sku                             = "Standard_B1s"
  instances                       = 2
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = filebase64("install.sh")
  depends_on  = [azurerm_resource_group.ntierlb, azurerm_lb_backend_address_pool.preschool]

}
