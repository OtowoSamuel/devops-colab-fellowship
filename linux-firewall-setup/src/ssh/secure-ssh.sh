#!/bin/bash

# Secure SSH server with key-based authentication

# Check if SSH key exists
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "SSH key does not exist. Generating a new SSH key..."
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    echo "SSH key generated. Please add the public key to the authorized_keys file."
else
    echo "SSH key already exists."
fi

# Copy public key to authorized_keys if not already present
if [ ! -f ~/.ssh/authorized_keys ]; then
    touch ~/.ssh/authorized_keys
fi

# Add public key to authorized_keys
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
echo "Public key added to authorized_keys."

# Set permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
echo "Permissions set for .ssh directory and authorized_keys file."

# Restart SSH service to apply changes
sudo systemctl restart ssh
echo "SSH service restarted. Key-based authentication is now configured."