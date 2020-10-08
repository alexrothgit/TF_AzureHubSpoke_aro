########################################
#
#
# This file is intended to create VM and it s needed pre-regs (Pub IP and NIC, VNET and Subnet created before)
#
#
########################################

########################################
#
#
# lets create my local vars first
#
#
########################################

# nothing

########################################
#
#
# finally the terraform part where stuff happens
#
#
########################################

#Create a public IP for VM Access

resource "azurerm_public_ip" "hub_pub_ip_1" {
    name = "az_hub_pub_ip_1"
    location = azurerm_resource_group.hub_rg_1.location
    resource_group_name = azurerm_resource_group.hub_rg_1.name
    allocation_method = "Dynamic"
    # idle_timeout_in_minutes = "30"
    sku                 = "Basic"

    tags = {
        env = "hub"
    }

}

# create NIC for the VM

resource "azurerm_network_interface" "hub_vm_nic_1" {
  name                = "az_hub_vm_nic_1"
  location            = azurerm_resource_group.hub_rg_1.location
  resource_group_name = azurerm_resource_group.hub_rg_1.name

  ip_configuration {
    name                          = "az_hub_vm_nic_1_config"
    subnet_id                     = azurerm_subnet.hub_subnet_1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.hub_pub_ip_1.id
  }
}


# now we create the VM itself (also vnet and subent needed, check other files)

resource "azurerm_virtual_machine" "hub_vm_1" {
  name                  = "az_hub_vm_1"
  location            = azurerm_resource_group.hub_rg_1.location
  resource_group_name = azurerm_resource_group.hub_rg_1.name
  network_interface_ids = [azurerm_network_interface.hub_vm_nic_1.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "az_hub_vm_osdisk_1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hub-vm-1"
    admin_username = var.hub_vm_admin_user
    admin_password = var.hub_vm_admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    env = "hub"
  }
}
