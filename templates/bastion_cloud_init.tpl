#cloud-config
write_files:
  - path: /home/${bastion_user}/.ssh/bastion_private_key.pem
    content: |
      ${indent(6, private_key)}
    owner: ${bastion_user}:${bastion_user}
    permissions: "0600"
  
  - path: /home/${bastion_user}/.ssh/config
    content: |
      Host *
          IdentityFile /home/${bastion_user}/.ssh/bastion_private_key.pem
          IdentitiesOnly yes
    owner: ${bastion_user}:${bastion_user}
    permissions: "0644"