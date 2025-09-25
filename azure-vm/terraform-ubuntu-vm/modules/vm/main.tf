# Public IP address
resource "azurerm_public_ip" "vm" {
  name                = "pip-ubuntu-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static" # Cheaper than Static for student use
  sku                 = "Standard"
  tags                = var.tags
}

# Network Interface
resource "azurerm_network_interface" "vm" {
  name                = "nic-ubuntu-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm.id
  }
}

# SSH key - read from file
locals {
  ssh_public_key = fileexists(var.ssh_public_key) ? file(var.ssh_public_key) : var.ssh_public_key
}

# Ubuntu VM
resource "azurerm_linux_virtual_machine" "main" {
  name                = "vm-ubuntu-learning"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  tags                = var.tags

  network_interface_ids = [
    azurerm_network_interface.vm.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = local.ssh_public_key
  }

  # Use a small, cost-effective OS disk
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30 # Small disk to save costs
  }

  # Use Ubuntu Server LTS - free and well-supported
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS" # Free tier eligible
    version   = "latest"
  }

  # Disable password authentication - SSH key only
  disable_password_authentication = true
}