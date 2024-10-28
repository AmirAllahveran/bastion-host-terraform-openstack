output "security_group_id" {
  description = "The ID of the security group for the bastion host."
  value       = openstack_networking_secgroup_v2.general_sg.id
}