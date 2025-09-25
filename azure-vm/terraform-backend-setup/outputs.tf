output "storage_account_name" {
    description = "Name of the created storage account for Terraform state"
    value = azurerm_storage_account.tfstate.name
}

output "storage_account_id" {
    description = "ID of the created storage account"
    value = azurerm_storage_account.tfstate.id
}

output "container_name" {
    description = "Name of the blob container for Terraform state"
    value = azurerm_storage_container.tfstate.name
}

output "resource_group_name" {
    description = "Resource group name used for the storage account"
    value = var.resource_group_name
}

output "backend_config" {
    description = "Backend configuration block for other Terraform projects"
    value = <<EOF

# Add this to your backend.tf file:
terraform {
  backend "azurerm" {
    resource_group_name  = "${var.resource_group_name}"
    storage_account_name = "${azurerm_storage_account.tfstate.name}"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
EOF
}