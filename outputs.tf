output "bastion_instance_floating_ip" {
  description = "Floating IP of the bastion host"
  value       = module.bastion_host.floating_ips
}

output "private_instance_ips" {
  description = "List of private IPs of the private instances"
  value       = module.private_instances.instance_ips
}

output "ssh_user" {
  description = "SSH user configured for accessing instances"
  value       = var.ssh_user
}