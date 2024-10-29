output "instance_ids" {
  description = "The IDs of the created instances."
  value       = [for instance in openstack_compute_instance_v2.bastion : instance.id]
}

output "instance_ips" {
  description = "The fixed IPs of the created instances."
  value       = [for instance in openstack_compute_instance_v2.bastion : instance.access_ip_v4]
}

output "floating_ips" {
  description = "The floating IPs associated with the instances (if assigned)."
  value       = [for assoc in openstack_networking_floatingip_associate_v2.bastion_fip_association : assoc.floating_ip]
}