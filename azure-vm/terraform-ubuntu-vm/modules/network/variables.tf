variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
}

variable "subnet_prefix" {
  description = "Subnet address prefix"
  type        = list(string)
}

variable "allowed_ssh_ips" {
  description = "Allowed SSH source IPs"
  type        = list(string)
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}