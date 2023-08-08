variable "resource_group_name" {
  default = "Academy"
}

variable "location" {
  default = "West Europe"
}
 
#sub

variable "virtual_network_name" {
  default = "academy-vnet"
}

variable "subname" {
  default = "adrian-sub"
}

variable "address_prefixes" {
  default = ["10.1.3.0/24"]
}

variable "servers"{
	type = any
}

#kv

variable "kv_name" {
  default = "kv1name"
}