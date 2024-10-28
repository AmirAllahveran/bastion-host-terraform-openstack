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

variable "floating_ip_pool" {
  description = "The floating IP pool from which to allocate a floating IP."
  type        = string
  default     = null
}

variable "floating_ip" {
  description = "The floating IP to associate with the bastion host."
  type        = string
  default = null
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

variable "instance_count" {
  type    = number
  default = 1
}

variable "assign_floating_ip" {
  type    = bool
  default = false
}

# Allow multiple security groups and networks
variable "security_groups" {
  type    = list(string)
  default = []
}

variable "networks" {
  type    = list(object({
    network_id = string
    fixed_ip   = optional(string)
  }))
}

# List of user data scripts
variable "user_data_scripts" {
  type    = list(string)
  default = []
}

# Optional SSH metadata
variable "ssh_metadata" {
  type    = map(string)
  default = {}
}
