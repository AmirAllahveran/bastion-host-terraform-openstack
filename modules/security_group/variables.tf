variable "security_group_name" {
  description = "The name of the security group for the bastion host."
  type        = string
}

variable "security_group_description" {
  description = "A description of the security group."
  type        = string
  default     = "Security group for bastion host."
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into the bastion host."
  type        = string
  default     = "0.0.0.0/0"  # Allowing all by default, but this should be restricted in production.
}
