# Create the bastion host
resource "openstack_compute_instance_v2" "bastion" {
  name            = var.instance_name
  image_name      = var.image_name
  flavor_name     = var.flavor_name
  key_pair        = var.key_pair_name
  security_groups = [var.security_group_name]
  network {
    uuid = var.network_id
  }

  # User data script for initial setup
  user_data = var.user_data

  # Enable SSH
  metadata = {
    ssh_user = var.ssh_user
  }
}

data "openstack_networking_port_v2" "bastion_port" {
  device_id  = openstack_compute_instance_v2.bastion.id
  network_id = openstack_compute_instance_v2.bastion.network.0.uuid
}

# Assign the floating IP created in the network module
resource "openstack_networking_floatingip_associate_v2" "bastion_fip_association" {
  floating_ip = var.floating_ip
  port_id     = data.openstack_networking_port_v2.bastion_port.id
  depends_on    = [openstack_compute_instance_v2.bastion]
}

