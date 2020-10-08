# Azure Network Security Group for onpre Network
#  deny to all except ssh (22)

resource "azurerm_network_security_group" "onprem_nsg_1" {
    name = "az_onprem_nsg_allow_ssh_22"
    resource_group_name = azurerm_resource_group.onprem_rg_1.name
    location = azurerm_resource_group.onprem_rg_1.location

    security_rule {
        name = "IN-SSH-22"
        priority = 1001
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*"
        destination_address_prefix = "*"

    }

    security_rule {
        name = "OUT-SSH-22"
        priority = 1001
        direction = "Outbound"
        access = "Deny"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*"
        destination_address_prefix = "*"

    }

    tags =  {
        env = "onprem"
    }

}

