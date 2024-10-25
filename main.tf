# Key pair module
module "bastion_keypair" {
  source = "./modules/keypair"

  keypair_name     = "bastion-ssh-key"
  public_key       = null # Leave null to generate a new keypair
  private_key_path = "./bastion-key.pem"
}

# Security group module
module "bastion_security_group" {
  source = "./modules/security_group"

  security_group_name = "bastion-sg"
  allowed_ssh_cidr    = "0.0.0.0/0" # Replace with your actual CIDR block
}

# Network module
module "bastion_network" {
  source = "./modules/network"

  network_name = "default"
  subnet_name  = "default_v4"
  # subnet_cidr         = "10.0.0.0/24"
  # gateway_ip          = "10.0.0.1"
  # router_name         = "bastion-router"
  external_network_name = "public" # Replace with your actual external network ID
}


# Bastion host module
module "bastion_host" {
  source = "./modules/compute"

  instance_name       = "bastion-host"
  image_name          = "Ubuntu 22.04"
  flavor_name         = "m1.large"
  key_pair_name       = module.bastion_keypair.keypair_name
  security_group_name = module.bastion_security_group.bastion_security_group_id
  network_id          = module.bastion_network.network_id
  floating_ip         = module.bastion_network.floating_ip # Use the created floating IP
  ssh_user            = "ubuntu"
  #   user_data          = file("path/to/user-data-script.sh")
}

# resource "openstack_compute_floatingip_associate_v2" "fip_association" {
#   floating_ip = openstack_networking_floatingip_v2.fip.address
#   instance_id = openstack_compute_instance_v2.bastion_instance.id
# }
