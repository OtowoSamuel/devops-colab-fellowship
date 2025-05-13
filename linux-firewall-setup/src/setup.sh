#!/bin/bash

# This script orchestrates the setup of the firewall and SSH server.

# Update package lists
echo "Updating package lists..."
sudo apt update

# Run UFW rules setup
echo "Configuring UFW firewall rules..."
bash ./firewall/ufw-rules.sh

# Run IPTables rules setup
echo "Configuring IPTables firewall rules..."
bash ./firewall/iptables-rules.sh

# Secure SSH server
echo "Securing SSH server..."
bash ./ssh/secure-ssh.sh

echo "Setup completed successfully."