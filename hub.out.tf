
########################################################
##
## Output
##
#########################################################

/*
data "azurerm_public_ip" "hub_pub_ip_1" {
  name                = azurerm_public_ip.hub_pub_ip_1.name
  resource_group_name = azurerm_resource_group.hub_rg_1.name
}

#output "hub_domain_name_label" {
#  value = data.azurerm_public_ip.hub_pub_ip_1.domain_name_label
#}

output "hub_public_ip_address" {
  value = data.azurerm_public_ip.hub_pub_ip_1.ip_address
}
*/