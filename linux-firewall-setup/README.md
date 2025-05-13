# Linux Firewall and SSH Security Setup

This project provides a comprehensive setup for configuring a firewall using UFW or IPTables and securing an SSH server with key-based authentication. It includes scripts for automation, configuration files for customization, and testing scripts to verify the setup.

## Objectives

- Configure a firewall to allow only specific traffic using UFW or IPTables.
- Secure the SSH server with key-based authentication.
- Test and document the network setup using nmap.

## Project Structure

```
linux-firewall-setup
├── src
│   ├── setup.sh                # Main setup script
│   ├── firewall
│   │   ├── ufw-rules.sh        # UFW rules configuration
│   │   └── iptables-rules.sh    # IPTables rules configuration
│   ├── ssh
│   │   ├── sshd_config         # SSH daemon configuration
│   │   └── secure-ssh.sh       # Key-based authentication setup
│   └── tests
│       ├── scan-ports.sh       # Port scanning script using nmap
│       └── test-ssh-access.sh   # SSH access testing script
├── configs
│   ├── allowed-services.conf    # Allowed services and ports
│   └── ssh-access-list.conf     # Authorized SSH users/IPs
├── keys
│   └── README.md                # SSH key generation and usage
├── docs
│   ├── firewall-setup.md        # Firewall setup documentation
│   ├── ssh-hardening.md         # SSH hardening best practices
│   └── security-testing.md       # Security testing instructions
└── README.md                    # Project overview and instructions
```

## Setup Instructions

1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Run the `setup.sh` script to configure the firewall and SSH server:
   ```bash
   chmod +x src/setup.sh
   ./src/setup.sh
   ```
4. Follow the instructions in the `keys/README.md` file to generate and use SSH keys for secure access.

## Usage Guidelines

- Use the provided scripts in the `src/firewall` directory to customize your firewall rules.
- Modify the `sshd_config` file in the `src/ssh` directory to adjust SSH settings as needed.
- Test your setup using the scripts in the `src/tests` directory to ensure everything is functioning correctly.

## Documentation

Refer to the `docs` directory for detailed documentation on firewall setup, SSH hardening, and security testing procedures.