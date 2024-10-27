variable "security_group_name" {
  type        = string
  description = "Name of the security group"
}

variable "security_group_description" {
  type        = string
  description = "Description of the security group"
}

variable "ingress_rules" {
  type = list(object({
    direction         = string
    ethertype         = string
    protocol          = string
    port_range_min    = number
    port_range_max    = number
    remote_ip_prefix  = string
    remote_group_id   = string
  }))
  description = "List of ingress rules to be applied to the security group"
  default     = []
}

variable "egress_rules" {
  type = list(object({
    direction         = string
    ethertype         = string
    protocol          = string
    port_range_min    = number
    port_range_max    = number
    remote_ip_prefix  = string
  }))
  description = "List of egress rules to be applied to the security group"
  default     = [
    {
      direction         = "egress"
      ethertype         = "IPv4"
      protocol          = "tcp"
      port_range_min    = 0
      port_range_max    = 0
      remote_ip_prefix  = "0.0.0.0/0"
    }
  ]
}
