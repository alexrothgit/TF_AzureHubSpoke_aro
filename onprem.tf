resource "azurerm_resource_group" "onprem_rg_1" {
    name = "az_onprem_rg_1"
    location = "eastus"

    tags = {
        env = "onprem"

    }
}

resource "azurerm_virtual_network" "onprem_virt_nw_1" {
    name = "az_onprem_vn_1"
    location = "eastus"
    # old # address_space = ["10.0.0.0/16"]
    address_space = ["192.168.0.0/22"]
    resource_group_name = azurerm_resource_group.onprem_rg_1.name

    tags = { 
        env = "onprem"
    }

}

resource "azurerm_subnet" "onprem_subnet_1" {
    name = "az_onprem_subnet_1"
    resource_group_name = azurerm_resource_group.onprem_rg_1.name
    virtual_network_name = azurerm_virtual_network.onprem_virt_nw_1.name
    # old # address_prefixes = ["10.0.2.0/24"]
    address_prefixes = ["192.168.2.0/24"]
}






