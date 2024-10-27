# Key pair module
module "bastion_keypair" {
  source = "./modules/keypair"

  keypair_name     = var.keypair_name
  public_key       = var.public_key # Leave null to generate a new keypair
  private_key_path = var.private_key_path
}

# Security group module
module "bastion_security_group" {
  source = "./modules/security_group"

  security_group_name        = var.security_group_name
  security_group_description = var.security_group_description
  ingress_rules              = var.bastion_ingress_rules
  egress_rules               = var.bastion_egress_rules
}

# Network module
module "bastion_network" {
  source = "./modules/network"

  network_name = var.network_name
  subnet_name  = var.subnet_name
  # subnet_cidr         = "10.0.0.0/24"
  # gateway_ip          = "10.0.0.1"
  # router_name         = "bastion-router"
  external_network_name = var.external_network_name # Replace with your actual external network
}

# Bastion host module
module "bastion_host" {
  source = "./modules/compute"

  instance_name       = var.instance_name
  image_name          = var.image_name
  flavor_name         = var.flavor_name
  key_pair_name       = module.bastion_keypair.keypair_name
  security_group_name = module.bastion_security_group.bastion_security_group_id
  network_id          = module.bastion_network.network_id
  floating_ip         = module.bastion_network.floating_ip # Use the created floating IP
  ssh_user            = var.ssh_user
  #   user_data          = file("path/to/user-data-script.sh")
}

# resource "openstack_compute_floatingip_associate_v2" "fip_association" {
#   floating_ip = openstack_networking_floatingip_v2.fip.address
#   instance_id = openstack_compute_instance_v2.bastion_instance.id
# }
