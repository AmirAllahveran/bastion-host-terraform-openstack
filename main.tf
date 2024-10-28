# Generate an SSH key pair for the bastion host
resource "tls_private_key" "bastion_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create key pair resource in OpenStack using the generated public key
resource "openstack_compute_keypair_v2" "bastion_key" {
  name       = var.bastion_keypair_name
  public_key = tls_private_key.bastion_ssh_key.public_key_openssh
}

# Template for cloud-init configuration
data "template_file" "cloud_init" {
  template = file("./templates/bastion_cloud_init.tpl")
  vars = {
    bastion_user = var.ssh_user
    private_key  = tls_private_key.bastion_ssh_key.private_key_pem
  }
}

# Module: Key Pair for Bastion
module "bastion_keypair" {
  source           = "./modules/keypair"
  keypair_name     = var.bastion_keypair_name
  public_key       = var.public_key
  private_key_path = var.private_key_path
}

# Module: Security Group for Bastion
module "bastion_security_group" {
  source                   = "./modules/security_group"
  security_group_name      = var.bastion_sg_name
  security_group_description = var.bastion_sg_description
  ingress_rules            = var.bastion_ingress_rules
  egress_rules             = var.default_egress_rules
}

# Module: Security Group for Private Instances
module "private_instances_security_group" {
  source                   = "./modules/security_group"
  security_group_name      = var.private_instances_sg_name
  security_group_description = "Security group for private instances"
  ingress_rules            = [{ /* allow from bastion security group */ }]
  egress_rules             = var.default_egress_rules
}

# Module: Network for Bastion
module "bastion_network" {
  source                   = "./modules/network"
  network_name             = var.network_name
  subnet_name              = var.subnet_name
  external_network_name    = var.external_network_name
}

# Module: Compute Resource for Bastion Host
module "bastion_host" {
  source                   = "./modules/compute"
  instance_name            = var.bastion_instance_name
  image_name               = var.image_name
  flavor_name              = var.bastion_flavor_name
  key_pair_name            = module.bastion_keypair.keypair_name
  security_groups          = [module.bastion_security_group.bastion_security_group_id]
  networks                 = [{ network_id = module.bastion_network.network_id }]
  floating_ip              = module.bastion_network.floating_ip
  ssh_user                 = var.ssh_user
  user_data_scripts        = [data.template_file.cloud_init.rendered]
}

# Module: Compute Resource for Private Instances
module "private_instances" {
  source                   = "./modules/compute"
  instance_count           = 1
  instance_name            = "private_instance"
  image_name               = var.image_name
  flavor_name              = var.private_instances_flavor_name
  key_pair_name            = openstack_compute_keypair_v2.bastion_key.name
  security_groups          = [module.private_instances_security_group.private_instances_security_group_id]
  networks                 = [{ network_id = module.bastion_network.network_id }]
  ssh_user                 = var.ssh_user
}
