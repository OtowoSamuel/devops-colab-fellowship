#!/bin/bash

# Allow SSH connections
ufw allow OpenSSH

# Allow specific ports (replace with actual ports as needed)
ufw allow 80/tcp    # Allow HTTP
ufw allow 443/tcp   # Allow HTTPS

# Deny all other incoming connections
ufw default deny incoming

# Allow outgoing connections
ufw default allow outgoing

# Enable UFW
ufw enable

# Show the status of UFW
ufw status verbose