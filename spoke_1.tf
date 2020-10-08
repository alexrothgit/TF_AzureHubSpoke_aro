########################################
#
#
# File: spoke_1.tf
# This file is intended to create spoke 1 network
#
#
########################################


########################################
#
#
# lets create my vars first
#
#
########################################

# nothing to declare

########################################
#
#
# finally part where the real stuff happens
# 1. create Resource Group
# 2. create VNET
# 3- create Subnet
#
#
########################################

# lets start with my respource group
resource "azurerm_resource_group" "spoke_1_rg_1" {
    name = "az_spoke_1_rg_1"
    location = "eastus"

    tags = {
        env = "spoke_1"

    }
}

# create SPOKE 1 VNET 10.1.0.0 with 65534 IPs

resource "azurerm_virtual_network" "spoke_1_virt_nw_1" {
    name = "az_spoke_1_vn_1"
    location = "eastus"
    address_space = ["10.1.0.0/16"]
    resource_group_name = azurerm_resource_group.spoke_1_rg_1.name

    tags = { 
        env = "spoke_1"
    }

}

# create SPOKE 1 Subnet with 10.1.1.0 with 255 IPs

resource "azurerm_subnet" "spoke_1_subnet_1" {
    name = "az_spoke_1_subnet_1"
    resource_group_name = azurerm_resource_group.spoke_1_rg_1.name
    virtual_network_name = azurerm_virtual_network.spoke_1_virt_nw_1.name
    address_prefixes = ["10.1.0.0/24"]
    
}



