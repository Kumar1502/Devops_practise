#Creating public ip for Load balancer
resource "azurerm_public_ip" "preschool" {
  name                = "preschool-lbpub"
  resource_group_name = azurerm_resource_group.ntierlb.name
  location            = azurerm_resource_group.ntierlb.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    environment = "Dev"
  }
  depends_on = [azurerm_resource_group.ntierlb]
}

# Create Load balancer
resource "azurerm_lb" "preschool" {
  name                = "preschool-lb"
  location            = azurerm_resource_group.ntierlb.location
  resource_group_name = azurerm_resource_group.ntierlb.name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "publicIpAddress"
    public_ip_address_id = azurerm_public_ip.preschool.id
  }
  tags = {
    environment = "Dev"
  }

  depends_on = [azurerm_resource_group.ntierlb, azurerm_public_ip.preschool]
}

#Create load balancer backend address pool
resource "azurerm_lb_backend_address_pool" "preschool" {
  name            = "preschool-pool"
  loadbalancer_id = azurerm_lb.preschool.id
  depends_on      = [azurerm_lb.preschool]

}

#Create load balancer probe
resource "azurerm_lb_probe" "preschool" {
  name                = "preschool-probe"
  port                = 80
  protocol            = "Http"
  probe_threshold     = 2
  interval_in_seconds = 5
  request_path        = "/"
  loadbalancer_id     = azurerm_lb.preschool.id
  depends_on          = [azurerm_lb.preschool]

}

#Create load balancer rule
resource "azurerm_lb_rule" "preschool" {
  name                           = "Httprule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.preschool.frontend_ip_configuration[0].name #"publicIpAddress" 
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.preschool.id]
  loadbalancer_id                = azurerm_lb.preschool.id
  probe_id                       = azurerm_lb_probe.preschool.id
  depends_on                     = [azurerm_lb.preschool, azurerm_lb_probe.preschool]

}
