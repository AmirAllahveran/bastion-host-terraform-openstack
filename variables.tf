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

variable "security_group_name" {
  description = "Name of the security group for the bastion host"
  type        = string
  default     = "bastion-sg"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block to allow SSH access"
  type        = string
  default     = "0.0.0.0/0"
}

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
