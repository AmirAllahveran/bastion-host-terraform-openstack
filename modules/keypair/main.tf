# Create or import a key pair
resource "openstack_compute_keypair_v2" "keypair" {
  name       = var.keypair_name

  # If public key is provided, import the existing key
  public_key = var.public_key

  # If no public key is provided, generate a new key pair
  provisioner "local-exec" {
    when    = create
    command = "echo '${self.private_key}' > ${var.private_key_path}"
  }
}
