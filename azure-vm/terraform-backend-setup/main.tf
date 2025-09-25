terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
        source  = "hashicorp/azurerm"
        version = "~> 3.0"
    }

    random = {
        source  = "hashicorp/random"
        version = "~> 3.0"
    }
  }

  # Using local backend for bootstrapping - this project creates the remote backend
  backend "local" {
    path = "terraform.tfstate" 
  }
}

provider "azurerm" {
  features {}
}

provider "random" {}

# Generate random suffix for storage account name (must be globally unique)
resource "random_string" "suffix" {
    length  = 8
    special = false
    lower   = true
    upper   = false  
}

# Create storage account for Terraform remote state
resource "azurerm_storage_account" "tfstate" {
    name = "tfstate${random_string.suffix.result}"
    resource_group_name = var.resource_group_name
    location = var.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    account_kind = "StorageV2"

    # Security best practices

    #enable_https_traffic_only = true
    https_traffic_only_enabled = true
    min_tls_version = "TLS1_2"

    # Enable soft delete protection

    blob_properties {
        delete_retention_policy {
            days = 7
        }
    }
    tags = var.tags
}

# Create blob container for Terraform state files
resource "azurerm_storage_container" "tfstate" {
    name = "tfstate"
    storage_account_name = azurerm_storage_account.tfstate.name
    container_access_type = "private"
}

