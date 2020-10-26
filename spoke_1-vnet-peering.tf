########################################
#
#
# Filename: spoke_1-vnet-peering.tf
#
# This file is intended to create a VNET Peering 
# between spoke-1 and  hub VNET 
# other dicrection to be found in hub-vnet-peering.tf
# 
#
########################################




resource "azurerm_virtual_network_peering" "spoke_1_virt_nw_1_peering_2_hub" {
  name                      = "az_spoke_1_peer_to_hub"
  resource_group_name       = azurerm_resource_group.spoke_1_rg_1.name
  virtual_network_name      = azurerm_virtual_network.spoke_1_virt_nw_1.name
  remote_virtual_network_id = azurerm_virtual_network.hub_virt_nw_1.id

  allow_forwarded_traffic   = true
  allow_gateway_transit     = true

}


