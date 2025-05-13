# SSH Hardening Best Practices

## 1. Use Key-Based Authentication
- Disable password authentication to prevent brute-force attacks.
- Generate SSH keys using `ssh-keygen` and copy the public key to the server using `ssh-copy-id`.

## 2. Configure SSH Daemon
- Edit the `sshd_config` file to implement the following settings:
  - `PermitRootLogin no` - Disable root login via SSH.
  - `PasswordAuthentication no` - Disable password authentication.
  - `ChallengeResponseAuthentication no` - Disable challenge-response authentication.
  - `UsePAM no` - Disable Pluggable Authentication Module.
  - `AllowUsers <username>` - Specify which users can log in via SSH.

## 3. Change the Default SSH Port
- Change the default SSH port from 22 to a non-standard port to reduce the risk of automated attacks.

## 4. Implement Firewall Rules
- Use UFW or IPTables to allow only specific IP addresses to connect to the SSH port.
- Example UFW command: `ufw allow from <allowed_ip> to any port <custom_port>`

## 5. Enable SSH Rate Limiting
- Use tools like `fail2ban` to monitor and block IP addresses that show malicious signs, such as too many failed login attempts.

## 6. Keep SSH Updated
- Regularly update the SSH server software to patch vulnerabilities.

## 7. Monitor SSH Access
- Regularly check logs in `/var/log/auth.log` for unauthorized access attempts.

## 8. Use Two-Factor Authentication (2FA)
- Consider implementing 2FA for an additional layer of security.

## Conclusion
By following these best practices, you can significantly enhance the security of your SSH server and protect it from unauthorized access.