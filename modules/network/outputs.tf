output "network_id" {
  description = "The ID of the created network."
  value       = data.openstack_networking_network_v2.existing_network.id
}

output "subnet_id" {
  description = "The ID of the created subnet."
  value       = data.openstack_networking_subnet_v2.existing_subnet.id
}

# output "router_id" {
#   description = "The ID of the created router."
#   value       = openstack_networking_router_v2.bastion_router.id
# }

output "floating_ip" {
  description = "The floating IP address for the bastion host."
  value       = openstack_networking_floatingip_v2.bastion_floating_ip.address
}