variable "keypair_name" {
  description = "The name of the SSH key pair."
  type        = string
}

variable "public_key" {
  description = "The public key to import. If not provided, a new key pair will be generated."
  type        = string
  default     = null
}

variable "private_key_path" {
  description = "The local file path where the private key will be saved if a new key pair is generated."
  type        = string
  default     = "./bastion-key.pem"
}
