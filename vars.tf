########################################
#
#
# File: vars.tf
#
#  This file should hold all generall aariable declaration 
#
#
########################################

# Username and PW for the OnPrem VM
variable "vm_admin_user" {
  type = string
}

variable "vm_admin_password" {
  type = string
}





# Secret Shared key for VPN Connection between ONprem and Hub
variable "vpn_shared_key" {
  type = string
}
