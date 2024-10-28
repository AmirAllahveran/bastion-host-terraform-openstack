# SSH Key Configuration
variable "bastion_keypair_name" {
  description = "Name of the SSH keypair for the bastion host"
  type        = string
  default     = "bastion-ssh-key"
}

variable "public_key" {
  description = "Public key for the bastion host keypair. Leave null to generate a new keypair"
  type        = string
  default     = null
}

variable "private_key_path" {
  description = "Path to save the bastion private key"
  type        = string
  default     = "./bastion-key.pem"
}

# Security Group Configuration
variable "bastion_sg_name" {
  type        = string
  description = "Name of the bastion security group"
  default     = "bastion-sg"
}

variable "bastion_sg_description" {
  type        = string
  description = "Description of the bastion security group"
  default     = "Security group for bastion host"
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
  description = "List of ingress rules for bastion security group"
  default     = []
}

variable "default_egress_rules" {
  type = list(object({
    direction        = string
    ethertype        = string
    protocol         = string
    port_range_min   = number
    port_range_max   = number
    remote_ip_prefix = string
  }))
  description = "Default egress rules for security groups"
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

# Network Configuration
variable "network_name" {
  description = "Name of the network"
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

# Bastion Host Configuration
variable "bastion_instance_name" {
  description = "Name of the bastion host instance"
  type        = string
  default     = "bastion-host"
}

variable "image_name" {
  description = "Name of the image for the bastion and private instances"
  type        = string
  default     = "Ubuntu 22.04"
}

variable "bastion_flavor_name" {
  description = "Flavor name for the bastion host"
  type        = string
  default     = "m1.large"
}

variable "private_instances_flavor_name" {
  description = "Flavor name for private instances"
  type        = string
  default     = "m1.large"
}

variable "private_instances_sg_name" {
  type = string
  description = "Name of the private instances security group"
  default = "private_instances_sg"
}

variable "ssh_user" {
  description = "SSH user for instance access"
  type        = string
  default     = "ubuntu"
}
