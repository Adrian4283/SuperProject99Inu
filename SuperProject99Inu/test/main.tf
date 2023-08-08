provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.59.0"
    }
  }
}

module "test" {
  source = "../"

servers = {
  vm_one = {
    vmname  = "vmone"
    vmsize  = "Standard_B1s"
    version = "linux"

  }

  vm_two = {
    vmname  = "vmtwo"
    vmsize  = "Standard_B1s"
    version = "windows"

  }

    vm_three = {
    vmname  = "vmthree"
    vmsize  = "Standard_B1s"
    version = "windows"

  }
}
}
