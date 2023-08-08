resource "azurerm_subnet" "test-sub" {
  name                 = var.subname
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes

}