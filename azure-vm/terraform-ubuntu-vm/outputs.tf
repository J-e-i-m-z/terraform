output "vm_public_ip" {
  description = "Public IP address of the Ubuntu VM"
  value       = module.vm.vm_public_ip
}

output "vm_ssh_command" {
  description = "SSH command to connect to the VM"
  value       = "ssh ${var.admin_username}@${module.vm.vm_public_ip}"
}

output "resource_group_name" {
  description = "Resource group containing the VM"
  value       = var.resource_group_name
}