# ---------------------------------
# SSH Key Configuration
# ---------------------------------

variable "bastion_keypair_name" {
  description = "Name of the SSH keypair for the bastion host"
  type        = string
  default     = "bastion-ssh-key"
}

variable "private_instance_keypair_name" {
  description = "Name of the SSH keypair for the private instances"
  type        = string
  default     = "private-instances-ssh-key"
}

variable "public_key" {
  description = "Public key for the bastion host keypair (optional, leave null to generate a new keypair)"
  type        = string
  default     = null
}

variable "private_key_path" {
  description = "Path to save the bastion private key file"
  type        = string
  default     = "./bastion-key.pem"
}

# ---------------------------------
# Security Group Configuration
# ---------------------------------

variable "bastion_sg_name" {
  description = "Name of the bastion security group"
  type        = string
  default     = "bastion-sg"
}

variable "bastion_sg_description" {
  description = "Description of the bastion security group"
  type        = string
  default     = "Security group for bastion host"
}

variable "private_instances_sg_name" {
  description = "Name of the private instances security group"
  type        = string
  default     = "private-instances-sg"
}

variable "private_instances_sg_description" {
  description = "Description of the private instances security group"
  type        = string
  default     = "Security group for private instances"
}

variable "bastion_ingress_rules" {
  description = "Ingress rules for bastion security group"
  type = list(object({
    direction        = string
    ethertype        = string
    protocol         = string
    port_range_min   = number
    port_range_max   = number
    remote_ip_prefix = string
    remote_group_id  = string
  }))
  default = []
}

variable "private_instance_ingress_rules" {
  description = "Ingress rules for private instance security group"
  type = list(object({
    direction        = string
    ethertype        = string
    protocol         = string
    port_range_min   = number
    port_range_max   = number
    remote_ip_prefix = string
    remote_group_id  = string
  }))
  default = []
}

variable "default_egress_rules" {
  description = "Default egress rules for security groups"
  type = list(object({
    direction        = string
    ethertype        = string
    protocol         = string
    port_range_min   = number
    port_range_max   = number
    remote_ip_prefix = string
  }))
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

# ---------------------------------
# Network Configuration
# ---------------------------------

variable "network_name" {
  description = "Name of the network to be used"
  type        = string
  default     = "default"
}

variable "subnet_name" {
  description = "Name of the subnet to be used"
  type        = string
  default     = "default_v4"
}

variable "external_network_name" {
  description = "Name of the external network to be used"
  type        = string
  default     = "public"
}

# ---------------------------------
# Bastion Host Configuration
# ---------------------------------

variable "bastion_instance_name" {
  description = "Name of the bastion host instance"
  type        = string
  default     = "bastion-host"
}

variable "bastion_flavor_name" {
  description = "Flavor (size) of the bastion host instance"
  type        = string
  default     = "m1.large"
}

# ---------------------------------
# Private Instances Configuration
# ---------------------------------

variable "private_instance_name" {
  description = "Base name for the private instances"
  type        = string
  default     = "private-instance"
}

variable "private_instances_flavor_name" {
  description = "Flavor (size) of private instances"
  type        = string
  default     = "m1.large"
}

# ---------------------------------
# General Instance Configuration
# ---------------------------------

variable "image_name" {
  description = "Image name to be used for both bastion and private instances"
  type        = string
  default     = "Ubuntu 22.04"
}

variable "ssh_user" {
  description = "SSH user for accessing instances"
  type        = string
  default     = "ubuntu"
}
