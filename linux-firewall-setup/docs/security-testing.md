# Security Testing Instructions

This document outlines the steps to test the security setup of the firewall and SSH server using `nmap` and other relevant tools.

## Prerequisites

Ensure that the following tools are installed on your testing machine:

- nmap
- ssh (for testing SSH access)

## Testing the Firewall Configuration

1. **Scan Open Ports:**
   Use `nmap` to scan the server for open ports. Replace `SERVER_IP` with the actual IP address of your server.

   ```bash
   nmap -sS -p- SERVER_IP
   ```

   This command performs a SYN scan on all ports. Review the output to ensure that only the allowed ports are open as per your firewall rules.

2. **Check Specific Ports:**
   If you want to check specific ports, you can specify them in the command. For example, to check ports 22 (SSH) and 80 (HTTP):

   ```bash
   nmap -p 22,80 SERVER_IP
   ```

3. **Verify Firewall Rules:**
   Compare the open ports from the `nmap` scan with the `allowed-services.conf` file to ensure compliance with your firewall configuration.

## Testing SSH Access

1. **Test SSH Connection:**
   Attempt to connect to the SSH server using the key-based authentication. Replace `USER` and `SERVER_IP` with your username and server IP address.

   ```bash
   ssh -i /path/to/private/key USER@SERVER_IP
   ```

   Ensure that the connection is successful and that you are not prompted for a password.

2. **Check Unauthorized Access:**
   Attempt to connect from an unauthorized IP address or with an incorrect key to verify that the SSH server is rejecting unauthorized access.

## Documenting Results

After performing the tests, document the results, including:

- Open ports discovered by `nmap`
- Successful and failed SSH connection attempts
- Any discrepancies between expected and actual configurations

This documentation will help in auditing the security setup and making necessary adjustments.