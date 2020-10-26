########################################
#
#
# Filename: hub-vnet-peering.tf
#
# This file is intended to create a VNET Peering 
# between hub and spoke-1 and 2 VNET 
# 
#
########################################




resource "azurerm_virtual_network_peering" "hub_1_virt_nw_1_peering_2_spoke_1" {
  name                      = "az_hub_peer_to_spoke_1"
  resource_group_name       = azurerm_resource_group.hub_rg_1.name
  virtual_network_name      = azurerm_virtual_network.hub_virt_nw_1.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_1_virt_nw_1.id

  allow_forwarded_traffic   = true
  allow_gateway_transit     = true

}



resource "azurerm_virtual_network_peering" "hub_1_virt_nw_1_peering_2_spoke_2" {
  name                      = "az_hub_peer_to_spoke_2"
  resource_group_name       = azurerm_resource_group.hub_rg_1.name
  virtual_network_name      = azurerm_virtual_network.hub_virt_nw_1.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_2_virt_nw_1.id

  allow_forwarded_traffic   = true
  allow_gateway_transit     = true

}

