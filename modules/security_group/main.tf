resource "openstack_networking_secgroup_v2" "general_sg" {
  name        = var.security_group_name
  description = var.security_group_description
}

resource "openstack_networking_secgroup_rule_v2" "ingress_rules" {
  for_each          = { for i, rule in var.ingress_rules : i => rule }
  direction         = each.value.direction
  ethertype         = each.value.ethertype
  protocol          = each.value.protocol
  port_range_min    = each.value.port_range_min
  port_range_max    = each.value.port_range_max
  security_group_id = openstack_networking_secgroup_v2.general_sg.id

  dynamic "remote_ip_prefix" {
    for_each = each.value.remote_ip_prefix != "" ? [each.value.remote_ip_prefix] : []
    content {
      remote_ip_prefix = each.value.remote_ip_prefix
    }
  }

  dynamic "remote_group_id" {
    for_each = each.value.remote_group_id != "" ? [each.value.remote_group_id] : []
    content {
      remote_group_id = each.value.remote_group_id
    }
  }
}


resource "openstack_networking_secgroup_rule_v2" "egress_rules" {
  for_each          = { for i, rule in var.egress_rules : i => rule }
  direction         = each.value.direction
  ethertype         = each.value.ethertype
  protocol          = each.value.protocol
  port_range_min    = each.value.port_range_min
  port_range_max    = each.value.port_range_max
  remote_ip_prefix  = each.value.remote_ip_prefix
  security_group_id = openstack_networking_secgroup_v2.general_sg.id
}
