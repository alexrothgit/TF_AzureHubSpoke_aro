########################################
#
#
# File: hub.vpngw.tf
# This file is intended to create the hubisses VPN GW
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



########################################
#
#
# finally, the part where the real stuff happens
#
#
########################################


# create Public IP for the VPN GW

resource "azurerm_public_ip" "hub_vpngw_pub_ip_1" {
    name = "az_hub_vpngw_pub_ip_1"
    location = azurerm_resource_group.hub_rg_1.location
    resource_group_name = azurerm_resource_group.hub_rg_1.name
    allocation_method = "Dynamic"
    sku                 = "Basic"

    tags = {
        env = "hub"
        usedby = "VPN GW"
    }
}

# create special Gateway subnet with name "GatewaySubnet" as error occured before
resource "azurerm_subnet" "hub_vpngw_subnet_1" {
  #name                 = "az_hub_GatewaySubnet"  # seems that this not work, why??
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub_rg_1.name
  virtual_network_name = azurerm_virtual_network.hub_virt_nw_1.name
  address_prefixes       = ["10.0.1.0/24"]
}

# we use the std. hub network, no need to create another one
# lets create teh gateway itself

resource "azurerm_virtual_network_gateway" "hub_vpn_gw" {
  name                = "az_hub_vpn_gw"
  location            = azurerm_resource_group.hub_rg_1.location
  resource_group_name = azurerm_resource_group.hub_rg_1.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    name                          = "hubVPNGWVnetconfiguration"
    public_ip_address_id          = azurerm_public_ip.hub_vpngw_pub_ip_1.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.hub_vpngw_subnet_1.id
  }
  
}


# create connection between VPN GWs ( Hub 2 OnPre)
resource "azurerm_virtual_network_gateway_connection" "hub2onprem_vpn_connection" {
  name                = "az_hub_2_onprem_von_connection"
  location            = azurerm_resource_group.hub_rg_1.location
  resource_group_name = azurerm_resource_group.hub_rg_1.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.hub_vpn_gw.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.onprem_vpn_gw.id

  shared_key = var.vpn_shared_key
}


