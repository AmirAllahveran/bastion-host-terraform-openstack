variable "instance_name" {
  description = "Name of the bastion host instance."
  type        = string
}

variable "image_name" {
  description = "The name of the image to use for the bastion host."
  type        = string
}

variable "flavor_name" {
  description = "The flavor (size) of the instance."
  type        = string
}

variable "key_pair_name" {
  description = "The name of the SSH key pair to use for access."
  type        = string
}

variable "security_group_name" {
  description = "The security group to associate with the instance."
  type        = string
}

variable "network_id" {
  description = "The network ID to associate with the instance."
  type        = string
}

variable "floating_ip_pool" {
  description = "The floating IP pool from which to allocate a floating IP."
  type        = string
  default     = null
}

variable "floating_ip" {
  description = "The floating IP to associate with the bastion host."
  type        = string
}

variable "ssh_user" {
  description = "The SSH user for accessing the bastion host."
  type        = string
  default     = "ubuntu"  # Adjust based on the image you're using
}

variable "user_data" {
  description = "Optional user data script for instance setup (e.g., cloud-init)."
  type        = string
  default     = null
}
