#cloud-config
write_files:
  - path: /home/${bastion_user}/.ssh/bastion_private_key.pem
    content: |
      ${private_key}
    permissions: "0600"
