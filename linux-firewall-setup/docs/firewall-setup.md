# Firewall Setup Documentation

## Overview

This document provides a step-by-step guide to configure the firewall on your Linux server using both UFW (Uncomplicated Firewall) and IPTables. It outlines the necessary commands and configurations to allow only specific traffic, ensuring a secure environment.

## Prerequisites

- A Linux server with root or sudo access.
- UFW or IPTables installed on the server.
- Basic knowledge of command-line operations.

## UFW Configuration

1. **Install UFW** (if not already installed):
   ```bash
   sudo apt-get install ufw
   ```

2. **Default Policies**:
   Set default policies to deny all incoming traffic and allow all outgoing traffic:
   ```bash
   sudo ufw default deny incoming
   sudo ufw default allow outgoing
   ```

3. **Allow Specific Services**:
   Use the `allowed-services.conf` file to specify which services and ports to allow. For example:
   ```bash
   sudo ufw allow ssh
   sudo ufw allow 80/tcp  # Allow HTTP
   sudo ufw allow 443/tcp # Allow HTTPS
   ```

4. **Enable UFW**:
   After configuring the rules, enable UFW:
   ```bash
   sudo ufw enable
   ```

5. **Check UFW Status**:
   Verify the status of UFW and the rules applied:
   ```bash
   sudo ufw status verbose
   ```

## IPTables Configuration

1. **Flush Existing Rules**:
   Start with a clean slate by flushing existing IPTables rules:
   ```bash
   sudo iptables -F
   ```

2. **Set Default Policies**:
   Set default policies to deny all incoming and allow all outgoing traffic:
   ```bash
   sudo iptables -P INPUT DROP
   sudo iptables -P FORWARD DROP
   sudo iptables -P OUTPUT ACCEPT
   ```

3. **Allow Specific Traffic**:
   Use the `iptables-rules.sh` script to allow specific traffic. For example:
   ```bash
   sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
   sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # Allow SSH
   sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT  # Allow HTTP
   sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT # Allow HTTPS
   ```

4. **Save IPTables Rules**:
   Save the rules to ensure they persist after a reboot:
   ```bash
   sudo iptables-save > /etc/iptables/rules.v4
   ```

5. **Check IPTables Rules**:
   Verify the current IPTables rules:
   ```bash
   sudo iptables -L -v
   ```

## Testing the Configuration

After configuring the firewall, use the `nmap` tool to test and document the open ports:

1. **Install nmap** (if not already installed):
   ```bash
   sudo apt-get install nmap
   ```

2. **Scan Open Ports**:
   Run the `scan-ports.sh` script to scan for open ports:
   ```bash
   ./src/tests/scan-ports.sh
   ```

3. **Test SSH Access**:
   Use the `test-ssh-access.sh` script to ensure SSH access is functioning correctly:
   ```bash
   ./src/tests/test-ssh-access.sh
   ```

## Conclusion

Following this guide will help you set up a secure firewall configuration using UFW or IPTables. Regularly review and update your firewall rules to adapt to changing security needs.