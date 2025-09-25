terraform {
  backend "azurerm" {
    resource_group_name  = "rg-devops-practice"
    storage_account_name = "tfstatek68d92l8"
    container_name       = "tfstate"
    key                  = "ubuntu-vm/terraform.tfstate"
  }
}
