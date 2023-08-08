//main
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}


data "azurerm_resources" "academy" {
  resource_group_name = var.resource_group_name
}

//subnets

module "application-subnet" {
  source              = "./modules/subnet"

  subname = var.subname
  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes = var.address_prefixes
}

//vms

module "application-vm" {
  source              = "./modules/vm"


  servers = var.servers

  subid = module.application-subnet.subnet_ids

}

#Create Key Vault Secret
resource "azurerm_key_vault_secret" "vmpassword" {

  for_each = module.application-vm

  name         = each.value.name
  value        = each.value.admin_password
  key_vault_id = azurerm_key_vault.kv1.id
  depends_on = [ azurerm_key_vault.kv1 ]
}

//akv

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv1" {

  name                        = var.kv_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false 
  sku_name = "standard"

  contact{
  email = "adrian.komorny@aardwark.com"
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "28265b43-ec99-4576-9965-6bf6fcb23759"

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}
