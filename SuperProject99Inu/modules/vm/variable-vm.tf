variable "resource_group_name" {
  default = "Academy"
}

variable "location" {
  default = "West Europe"
}

variable "servers" {
 type = any
}

#nic

variable "subid" {
 type = any
}

variable "windows" {
default = "windows"
}

variable "linux" {
default = "linux"
}