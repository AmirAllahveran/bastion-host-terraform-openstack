resource "openstack_networking_secgroup_v2" "bastion_sg" {
  name        = var.security_group_name
  description = var.security_group_description
}

# SSH access (Port 22) for bastion host
resource "openstack_networking_secgroup_rule_v2" "bastion_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.allowed_ssh_cidr
  security_group_id = openstack_networking_secgroup_v2.bastion_sg.id
}

# Optional: Egress rule to allow all outbound traffic
resource "openstack_networking_secgroup_rule_v2" "all_egress" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 0
  port_range_max    = 0
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.bastion_sg.id
}
