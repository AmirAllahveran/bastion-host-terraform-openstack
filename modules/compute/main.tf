resource "openstack_compute_instance_v2" "bastion" {
  count           = var.instance_count
  name            = "${var.instance_name}-${count.index}"
  image_name      = var.image_name
  flavor_name     = var.flavor_name
  key_pair        = var.key_pair_name
  security_groups = var.security_groups

  dynamic "network" {
    for_each = var.networks
    content {
      uuid    = network.value.network_id
    }
  }

  user_data = join("\n", var.user_data_scripts)

  metadata = merge({ ssh_user = var.ssh_user }, var.ssh_metadata)
}

data "openstack_networking_port_v2" "bastion_port" {
  count      = var.instance_count
  device_id  = openstack_compute_instance_v2.bastion[count.index].id
  network_id = openstack_compute_instance_v2.bastion[count.index].network.0.uuid
}

resource "openstack_networking_floatingip_associate_v2" "bastion_fip_association" {
  count      = var.assign_floating_ip ? var.instance_count : 0
  floating_ip = var.floating_ip
  port_id     = data.openstack_networking_port_v2.bastion_port[count.index].id
  depends_on  = [openstack_compute_instance_v2.bastion]
}
