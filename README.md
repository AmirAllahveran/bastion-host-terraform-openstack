# Terraform OpenStack Infrastructure

This project configures and deploys an OpenStack infrastructure using Terraform. The setup includes a bastion host and private instances, with SSH access and network security tailored for secure management and controlled access.

## Project Structure

- **Key Pair for SSH Access**: Generates SSH keys for secure access to instances.
- **Cloud-Init Configuration**: Configures instance startup scripts for additional setup.
- **Security Groups**: Sets up firewall rules to manage access to the bastion host and private instances.
- **Network Configuration**: Configures the network and subnet for the bastion and private instances.
- **Compute Instances**: Provisions both the bastion host and private instances in OpenStack.

## Requirements

- Terraform 0.12+ 
- Access to an OpenStack environment with API credentials
- SSH access for managing resources via the bastion host

## Variables

The following are essential variables required in the `terraform.tfvars` file:

| Variable                      | Description                                                |
| ----------------------------- | ---------------------------------------------------------- |
| `private_instance_keypair_name` | Key pair name for private instance access                |
| `bastion_keypair_name`         | Key pair name for the bastion host                        |
| `public_key`                   | Public key path for the SSH key                           |
| `private_key_path`             | Path to store the private key                             |
| `ssh_user`                     | SSH user for connecting to instances                      |
| `bastion_sg_name`              | Security group name for the bastion host                  |
| `bastion_sg_description`       | Security group description for the bastion host           |
| `bastion_ingress_rules`        | Ingress rules for the bastion host                        |
| `default_egress_rules`         | Default egress rules for all instances                    |
| `private_instance_ingress_rules` | Ingress rules for private instances                    |
| `private_instances_sg_name`    | Security group name for private instances                 |
| `private_instances_sg_description` | Security group description for private instances   |
| `network_name`                 | Name of the network                                       |
| `subnet_name`                  | Name of the subnet                                        |
| `external_network_name`        | Name of the external network                              |
| `bastion_instance_name`        | Name of the bastion host instance                         |
| `image_name`                   | Image to use for instances                                |
| `bastion_flavor_name`          | Flavor for the bastion host                               |
| `private_instance_name`        | Name of the private instance                              |
| `private_instances_flavor_name` | Flavor for private instances                           |

## Modules

### Key Pair Module
- Generates a 4096-bit RSA SSH key pair.
- Uses the generated public key to create an OpenStack key pair for secure instance access.

### Security Group Module
- Configures firewall rules for both the bastion host and private instances.
- Allows access to private instances from the bastion host.

### Network Module
- Sets up the network and subnet configuration for the bastion host and private instances.

### Compute Module
- Provisions compute resources, including a bastion host with a floating IP and private instances accessible only from the bastion host.

## Deployment Steps

1. **Initialize Terraform**:  
   ```bash
   terraform init
   ```

2. **Review the Plan**:  
   ```bash
   terraform plan
   ```

3. **Apply Configuration**:  
   ```bash
   terraform apply
   ```

4. **Access the Bastion Host**:  
   Use the private key generated in the `private_key_path` to SSH into the bastion host.

## Notes

- **Bastion Host**: Acts as the gateway for managing private instances.
- **Cloud-Init**: Sets up essential configurations on instance launch, including the SSH key and user setup.
- **Private Instances**: No public IPs are assigned; access is only allowed via the bastion host for added security.

## Clean Up

To destroy all resources created by this configuration:

```bash
terraform destroy
```

## Troubleshooting

- **SSH Issues**: Ensure the private key path is correct and permissions are set appropriately.
- **Instance Not Accessible**: Check security group rules and verify network connectivity.