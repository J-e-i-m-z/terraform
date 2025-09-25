terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Network module
module "network" {
  source = "./modules/network"

  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_address_space  = var.vnet_address_space
  subnet_prefix       = var.subnet_prefix
  allowed_ssh_ips     = var.allowed_ssh_ips
  tags                = var.tags
}

# VM module
module "vm" {
  source = "./modules/vm"

  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = module.network.subnet_id
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  tags                = var.tags

  depends_on = [module.network]
}