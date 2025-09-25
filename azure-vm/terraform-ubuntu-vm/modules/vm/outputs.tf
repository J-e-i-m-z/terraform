output "vm_id" {
  description = "Virtual Machine ID"
  value       = azurerm_linux_virtual_machine.main.id
}

output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.vm.ip_address
}

output "vm_private_ip" {
  description = "Private IP address of the VM"
  value       = azurerm_network_interface.vm.private_ip_address
}