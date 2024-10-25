# # Create a network
# resource "openstack_networking_network_v2" "bastion_network" {
#   name           = var.network_name
#   admin_state_up = true
# }

# # Create a subnet
# resource "openstack_networking_subnet_v2" "bastion_subnet" {
#   name             = var.subnet_name
#   network_id       = openstack_networking_network_v2.bastion_network.id
#   cidr             = var.subnet_cidr
#   ip_version       = 4
#   gateway_ip       = var.gateway_ip
#   enable_dhcp      = var.enable_dhcp
#   dns_nameservers  = var.dns_nameservers
# }

# Reference the existing network
data "openstack_networking_network_v2" "existing_network" {
  name = var.network_name
}

# Reference the existing subnet
data "openstack_networking_subnet_v2" "existing_subnet" {
  name = var.subnet_name
  network_id = data.openstack_networking_network_v2.existing_network.id
}

# # Create a router
# resource "openstack_networking_router_v2" "bastion_router" {
#   name           = var.router_name
#   admin_state_up = true
#   external_network_name = var.external_network_name
# }

# # Attach subnet to router
# resource "openstack_networking_router_interface_v2" "bastion_router_interface" {
#   router_id = openstack_networking_router_v2.bastion_router.id
#   subnet_id = openstack_networking_subnet_v2.bastion_subnet.id
# }

# Create a floating IP for external access
resource "openstack_networking_floatingip_v2" "bastion_floating_ip" {
  pool = var.external_network_name
}
