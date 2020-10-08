########################################
#
#
# File: onprem.vpngw.tf
# This file is intended to create the Onpremisses VPN GW
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

# nothing to declare??

########################################
#
#
# finally, the part where the real stuff happens
#
#
########################################


# create Public IP for the VPN GW

resource "azurerm_public_ip" "onprem_vpngw_pub_ip_1" {
    name = "az_onprem_vpngw_pub_ip_1"
    location = azurerm_resource_group.onprem_rg_1.location
    resource_group_name = azurerm_resource_group.onprem_rg_1.name
    allocation_method = "Dynamic"
    sku                 = "Basic"

    tags = {
        env = "onprem"
        usedby = "VPN GW"
    }
}

# create special Gateway subnet with name "GatewaySubnet" as error occured before
resource "azurerm_subnet" "onprem_vpngw_subnet_1" {
  # name                 = "az_onprem_GatewaySubnet" # nned to check if that name also works
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.onprem_rg_1.name
  virtual_network_name = azurerm_virtual_network.onprem_virt_nw_1.name
  address_prefixes       = ["192.168.1.0/24"]
}

# we use the std. onprem network, no need to create another one
# lets create teh gateway itself

resource "azurerm_virtual_network_gateway" "onprem_vpn_gw" {
  name                = "az_onprem_vpn_gw"
  location            = azurerm_resource_group.onprem_rg_1.location
  resource_group_name = azurerm_resource_group.onprem_rg_1.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    name                          = "OnpremVPNGWVnetconfiguration"
    public_ip_address_id          = azurerm_public_ip.onprem_vpngw_pub_ip_1.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.onprem_vpngw_subnet_1.id
  }
  
}

# create connection between VPN GWs ( Onpre 2 Hub)
resource "azurerm_virtual_network_gateway_connection" "onprem2hub_vpn_connection" {
  name                = "az_Onprem_2_hub_von_connection"
  location            = azurerm_resource_group.onprem_rg_1.location
  resource_group_name = azurerm_resource_group.onprem_rg_1.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.onprem_vpn_gw.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.hub_vpn_gw.id

  shared_key = var.vpn_shared_key
}

