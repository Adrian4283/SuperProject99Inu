resource "random_password" "password" {

  for_each = var.servers

  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

##Create Key Vault Secret
#resource "azurerm_key_vault_secret" "vmpassword" {
#  name         = "vmpassword"
#  value        = random_password.password.result
#  key_vault_id = azurerm_key_vault.kv1.id
#  depends_on = [ azurerm_key_vault.kv1 ]
#}


resource "azurerm_network_interface" "test-ni" {

  for_each = var.servers

  name                = "${each.value.vmname}-infacename"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${each.value.vmname}-ipconfname"
    subnet_id                     = var.subid
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "test-vm" {  

  #for_each = var.servers
  for_each = { for k, v in var.servers: k => v if v.version == var.windows}


  name                = each.value.vmname
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = each.value.vmsize
  admin_username      = "adminuser"
  admin_password      = random_password.password[each.key].result
  network_interface_ids = ["${azurerm_network_interface.test-ni[each.key].id}"]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "test-vm" {

  #for_each = var.servers
  for_each = { for k, v in var.servers: k => v if v.version == var.linux}

  name                = each.value.vmname
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = each.value.vmsize
  admin_password      = random_password.password[each.key].result
  disable_password_authentication = false
  admin_username      = "adminuser"
  network_interface_ids = ["${azurerm_network_interface.test-ni[each.key].id}"]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

}
