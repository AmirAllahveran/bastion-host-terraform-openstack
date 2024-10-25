variable "network_name" {
  description = "The name of the network."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

# variable "subnet_cidr" {
#   description = "The CIDR block for the subnet."
#   type        = string
# }

# variable "gateway_ip" {
#   description = "The gateway IP address for the subnet."
#   type        = string
#   default     = null  # Can be set explicitly or use default
# }

# variable "enable_dhcp" {
#   description = "Enable DHCP on the subnet."
#   type        = bool
#   default     = true
# }

# variable "dns_nameservers" {
#   description = "A list of DNS nameservers for the subnet."
#   type        = list(string)
#   default     = ["8.8.8.8", "8.8.4.4"]  # Google DNS by default
# }

# variable "router_name" {
#   description = "The name of the router."
#   type        = string
# }

variable "external_network_name" {
  description = "The external network name to which the floating ip will connect."
  type        = string
}
