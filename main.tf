# ---------------------------------
# Key Pair for SSH Access
# ---------------------------------

# Generate an SSH key pair for the bastion host
resource "tls_private_key" "bastion_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create key pair resource in OpenStack using the generated public key
resource "openstack_compute_keypair_v2" "bastion_key" {
  name       = var.private_instance_keypair_name
  public_key = tls_private_key.bastion_ssh_key.public_key_openssh
}

module "bastion_keypair" {
  source = "./modules/keypair"

  keypair_name     = var.bastion_keypair_name
  public_key       = var.public_key
  private_key_path = var.private_key_path
}

# ---------------------------------
# Cloud-Init Configuration
# ---------------------------------

# Template for cloud-init configuration
locals {
  cloud_init_content = templatefile("${path.module}/templates/bastion_cloud_init.tpl", {
    bastion_user = var.ssh_user
    private_key  = tls_private_key.bastion_ssh_key.private_key_pem
  })
}


# ---------------------------------
# Security Groups
# ---------------------------------

# Module: Security Group for Bastion
module "bastion_security_group" {
  source = "./modules/security_group"

  security_group_name        = var.bastion_sg_name
  security_group_description = var.bastion_sg_description
  ingress_rules              = var.bastion_ingress_rules
  egress_rules               = var.default_egress_rules
}

# Create customized ingress rules for private instances allowing access from the bastion
locals {
  private_instance_rules_with_bastion_access = [
    for rule in var.private_instance_ingress_rules : merge(rule, { remote_group_id = module.bastion_security_group.security_group_id })
  ]
}

# Module: Security Group for Private Instances
module "private_instances_security_group" {
  source = "./modules/security_group"

  security_group_name        = var.private_instances_sg_name
  security_group_description = var.private_instances_sg_description
  ingress_rules              = local.private_instance_rules_with_bastion_access
  egress_rules               = var.default_egress_rules
}

# ---------------------------------
# Network Configuration
# ---------------------------------

# Module: Network for Bastion and Private Instances
module "bastion_network" {
  source = "./modules/network"

  network_name          = var.network_name
  subnet_name           = var.subnet_name
  external_network_name = var.external_network_name
}

# ---------------------------------
# Compute Instances
# ---------------------------------

# Module: Compute Resource for Bastion Host
module "bastion_host" {
  source = "./modules/compute"

  instance_name      = var.bastion_instance_name
  image_name         = var.image_name
  flavor_name        = var.bastion_flavor_name
  key_pair_name      = module.bastion_keypair.keypair_name
  security_groups    = [module.bastion_security_group.security_group_id]
  networks           = [{ network_id = module.bastion_network.network_id }]
  floating_ip        = module.bastion_network.floating_ip
  ssh_user           = var.ssh_user
  user_data_script   = local.cloud_init_content
  assign_floating_ip = true
}

# Module: Compute Resource for Private Instances
module "private_instances" {
  source = "./modules/compute"

  instance_count  = 1
  instance_name   = var.private_instance_name
  image_name      = var.image_name
  flavor_name     = var.private_instances_flavor_name
  key_pair_name   = openstack_compute_keypair_v2.bastion_key.name
  security_groups = [module.private_instances_security_group.security_group_id]
  networks        = [{ network_id = module.bastion_network.network_id }]
  ssh_user        = var.ssh_user
}
