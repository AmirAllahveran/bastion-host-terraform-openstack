variable "instance_count" {
  description = "Number of instances to create."
  type        = number
  default     = 1
}

variable "instance_name" {
  description = "Name prefix for the instance."
  type        = string
}

variable "image_name" {
  description = "The name of the image to use for the instance."
  type        = string
}

variable "flavor_name" {
  description = "The flavor to use for the instance."
  type        = string
}

variable "key_pair_name" {
  description = "The key pair name to use for SSH access."
  type        = string
}

variable "security_groups" {
  description = "A list of security groups to assign to the instance."
  type        = list(string)
  default     = []
}

variable "networks" {
  description = "A list of network configurations. Each network should have a 'network_id' and optionally a 'fixed_ip'."
  type        = list(object({
    network_id = string
    fixed_ip   = optional(string)
  }))
}

variable "user_data_scripts" {
  description = "A list of user data scripts to be executed on instance launch."
  type        = list(string)
  default     = []
}

variable "ssh_user" {
  description = "The SSH username for accessing the instance."
  type        = string
}

variable "ssh_metadata" {
  description = "Additional metadata to add for SSH configuration."
  type        = map(string)
  default     = {}
}

variable "assign_floating_ip" {
  description = "Whether to assign a floating IP to the instance."
  type        = bool
  default     = false
}

variable "floating_ip" {
  description = "Floating IP to associate with the instance."
  type        = string
  default     = null
}
