variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the VM"
  type        = string
}

variable "vm_size" {
  description = "VM size"
  type        = string
}

variable "admin_username" {
  description = "Admin username"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key file path or content"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}