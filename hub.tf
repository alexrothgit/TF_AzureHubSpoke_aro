resource "azurerm_resource_group" "hub_rg_1" {
    name = "az_hub_rg_1"
    location = "westus"

    tags = {
        env = "hub"
    }

}

resource "azurerm_virtual_network" "hub_virt_nw_1" {
    name = "az_hub_vn_1"
    location = "westus"
    address_space = ["10.0.0.0/16"]
    resource_group_name = azurerm_resource_group.hub_rg_1.name

    tags = {
        env = "hub"
    }
}

resource "azurerm_subnet" "hub_subnet_1" {
    name = "az_hub_subnet_10_0_2"
    resource_group_name = azurerm_resource_group.hub_rg_1.name
    virtual_network_name = azurerm_virtual_network.hub_virt_nw_1.name
    address_prefixes = ["10.0.2.0/24"]

}















