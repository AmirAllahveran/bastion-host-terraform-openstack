output "keypair_name" {
  description = "The name of the SSH key pair."
  value       = openstack_compute_keypair_v2.keypair.name
}

output "private_key_path" {
  description = "The path to the generated private key (if applicable)."
  value       = var.private_key_path
}
