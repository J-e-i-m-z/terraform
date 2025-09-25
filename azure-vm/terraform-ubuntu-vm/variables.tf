variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
  default     = "rg-devops-practice"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "southafricanorth"


}

variable "vm_size" {
  description = "VM size - choose cost-conscious options for students"
  type        = string
  default     = "Standard_B1s" # Cheap burstable instance

}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "jamez"
}

variable "ssh_public_key" {
  description = "Path to SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefix" {
  description = "Address prefix for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "allowed_ssh_ips" {
  description = "List of IP addresses allowed to SSH to the VM"
  type        = list(string)
  default     = ["0.0.0.0/0"] # WARNING: In production, restrict this!
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "DevOps-Practice"
    Environment = "Learning"
    CostCenter  = "Student"
  }
}