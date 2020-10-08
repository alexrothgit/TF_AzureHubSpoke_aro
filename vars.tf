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
variable "onprem_vm_admin_user" {
  type = string
}

variable "onprem_vm_admin_password" {
  type = string
}


# Username and PW for the HUB VM
variable "hub_vm_admin_user" {
  type = string
}

variable "hub_vm_admin_password" {
  type = string
}


# Secret Shared key for VPN Connection between ONprem and Hub
variable "vpn_shared_key" {
  type = string
}
