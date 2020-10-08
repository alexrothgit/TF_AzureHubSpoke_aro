
########################################################
##
## Output Onprem
##
#########################################################

/*
data "azurerm_public_ip" "onprem_pub_ip_1" {
  name                = azurerm_public_ip.onprem_pub_ip_1.name
  resource_group_name = azurerm_resource_group.onprem_rg_1.name
}

#output "onprem_domain_name_label" {
#  value = data.azurerm_public_ip.onprem_pub_ip_1.domain_name_label
#}

output "onprem_public_ip_address" {
  value = data.azurerm_public_ip.onprem_pub_ip_1.ip_address
}
*/