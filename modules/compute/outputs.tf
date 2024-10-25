output "bastion_instance_id" {
  description = "The ID of the bastion host instance."
  value       = openstack_compute_instance_v2.bastion.id
}

output "bastion_public_ip" {
  description = "The public floating IP of the bastion host."
  value       = var.floating_ip
}
