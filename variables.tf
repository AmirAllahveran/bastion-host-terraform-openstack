##### SSH-key #####
variable "keypair_name" {
  description = "Name of the SSH keypair for the bastion host"
  type        = string
  default     = "bastion-ssh-key"
}

variable "public_key" {
  description = "Public key to use for the bastion keypair. Leave null to generate a new keypair"
  type        = string
  default     = null
}

variable "private_key_path" {
  description = "Path to save the private key for the bastion"
  type        = string
  default     = "./bastion-key.pem"
}

##### Security Group #####
variable "security_group_name" {
  type        = string
  description = "Name of the security group"
}

variable "security_group_description" {
  type        = string
  description = "Description of the security group"
}

variable "bastion_ingress_rules" {
  type = list(object({
    direction        = string
    ethertype        = string
    protocol         = string
    port_range_min   = number
    port_range_max   = number
    remote_ip_prefix = string
    remote_group_id  = string
  }))
  description = "List of ingress rules to be applied to the security group"
  default     = []
}

variable "bastion_egress_rules" {
  type = list(object({
    direction        = string
    ethertype        = string
    protocol         = string
    port_range_min   = number
    port_range_max   = number
    remote_ip_prefix = string
  }))
  description = "List of egress rules to be applied to the security group"
  default = [
    {
      direction        = "egress"
      ethertype        = "IPv4"
      protocol         = "tcp"
      port_range_min   = 0
      port_range_max   = 0
      remote_ip_prefix = "0.0.0.0/0"
    }
  ]
}

##### Security Group #####
variable "network_name" {
  description = "Name of the network to use"
  type        = string
  default     = "default"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "default_v4"
}

variable "external_network_name" {
  description = "Name of the external network"
  type        = string
  default     = "public"
}

##### Bastion Host #####
variable "instance_name" {
  description = "Name of the bastion host instance"
  type        = string
  default     = "bastion-host"
}

variable "image_name" {
  description = "Name of the image for the instance"
  type        = string
  default     = "Ubuntu 22.04"
}

variable "flavor_name" {
  description = "Flavor name for the instance"
  type        = string
  default     = "m1.large"
}

variable "ssh_user" {
  description = "SSH user for accessing the instance"
  type        = string
  default     = "ubuntu"
}
