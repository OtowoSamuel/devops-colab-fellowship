# Ansible Web Server and Database Infrastructure

This Ansible project provides automated deployment and configuration of web servers with Nginx and database servers with MySQL, supporting role-based configurations for different environments (development and production).

## Project Structure

```
├── ansible.cfg                 # Ansible configuration
├── site.yml                   # Main playbook for full deployment
├── webserver.yml              # Web server only deployment
├── database.yml               # Database server only deployment
├── inventories/               # Environment-specific inventories
│   ├── dev/
│   │   └── hosts             # Development environment hosts
│   └── prod/
│       └── hosts             # Production environment hosts
├── group_vars/               # Group-specific variables
│   ├── dev.yml              # Development environment variables
│   ├── prod.yml             # Production environment variables
│   ├── webservers.yml       # Web server group variables
│   └── dbservers.yml        # Database server group variables
├── host_vars/               # Host-specific variables (optional)
└── roles/                   # Ansible roles
    ├── common/              # Common configuration for all servers
    ├── nginx/               # Nginx web server configuration
    └── database/            # MySQL database configuration
```

## Features

### Web Server (Nginx)
- ✅ Automated Nginx installation and configuration
- ✅ SSL/TLS support with self-signed certificates
- ✅ Security headers and best practices
- ✅ Gzip compression
- ✅ Custom error pages and health checks
- ✅ Environment-specific performance tuning
- ✅ Log rotation and monitoring

### Database Server (MySQL)
- ✅ MySQL installation and secure configuration
- ✅ Database and user creation
- ✅ Performance optimization based on environment
- ✅ Automated backup system with retention
- ✅ Security hardening (remove test DB, anonymous users)
- ✅ Firewall configuration
- ✅ Monitoring and logging

### Infrastructure Management
- ✅ Role-based deployment (dev/prod environments)
- ✅ Common system configuration
- ✅ Firewall management (UFW/firewalld)
- ✅ User and directory management
- ✅ Package management and updates

## Quick Start

### Prerequisites
- Ansible 2.9+ installed on control machine
- SSH access to target servers
- Sudo privileges on target servers

### 1. Update Inventory
Edit the inventory files to match your infrastructure:

**Development Environment:**
```bash
vim inventories/dev/hosts
```

**Production Environment:**
```bash
vim inventories/prod/hosts
```

### 2. Configure Variables
Update environment-specific variables:

```bash
# Development settings
vim group_vars/dev.yml

# Production settings  
vim group_vars/prod.yml
```

### 3. Deploy Infrastructure

**Full deployment (web + database):**
```bash
# Development
ansible-playbook -i inventories/dev/hosts site.yml

# Production
ansible-playbook -i inventories/prod/hosts site.yml
```

**Web servers only:**
```bash
ansible-playbook -i inventories/dev/hosts webserver.yml
```

**Database servers only:**
```bash
ansible-playbook -i inventories/dev/hosts database.yml
```

### 4. Verify Deployment
Access your web servers at their configured IP addresses:
- HTTP: `http://your-server-ip`
- HTTPS: `https://your-server-ip` (if SSL enabled)
- Health check: `http://your-server-ip/health`

## Environment Configuration

### Development Environment
- Lower resource allocation
- Debug logging enabled
- SSL disabled by default
- Simplified security settings
- Local firewall disabled

### Production Environment  
- Optimized performance settings
- Warning-level logging
- SSL enabled with certificates
- Enhanced security configuration
- Automated backups enabled
- Strict firewall rules

## Security Features

### Web Server Security
- Server tokens disabled
- Security headers (XSS, CSRF, etc.)
- SSL/TLS with modern ciphers
- Rate limiting capabilities
- Access log monitoring

### Database Security
- Root password protection
- Removal of default test database
- Anonymous user cleanup  
- Network access restrictions
- Encrypted connections support

## Backup Strategy

### Database Backups
- Automated daily backups (production)
- Configurable retention period
- Compressed backup files
- Backup verification
- Email notifications (configurable)

### Configuration Backups
- Automatic backup of modified configuration files
- Version control integration ready

## Monitoring and Maintenance

### Log Management
- Centralized logging configuration
- Log rotation policies
- Error log monitoring
- Access log analysis ready

### Health Checks
- Built-in health check endpoints
- Service status monitoring
- Automated alerting capabilities

## Customization

### Adding Custom Nginx Sites
1. Create new template in `roles/nginx/templates/`
2. Add site configuration to `roles/nginx/tasks/main.yml`
3. Update variables in group_vars or host_vars

### Database Schema Management
1. Add schema files to `roles/database/files/`
2. Create tasks for schema deployment
3. Update database role tasks

### Additional Roles
1. Create new role directory under `roles/`
2. Follow existing role structure
3. Add role to playbooks as needed

## Troubleshooting

### Common Issues

**Connection Issues:**
```bash
# Test connectivity
ansible all -i inventories/dev/hosts -m ping

# Check SSH access
ssh -i ~/.ssh/id_rsa ubuntu@your-server-ip
```

**Service Issues:**
```bash
# Check service status
ansible webservers -i inventories/dev/hosts -m service -a "name=nginx state=started"
ansible dbservers -i inventories/dev/hosts -m service -a "name=mysql state=started"
```

**Configuration Validation:**
```bash
# Test Nginx configuration
ansible webservers -i inventories/dev/hosts -m command -a "nginx -t"

# Check MySQL status
ansible dbservers -i inventories/dev/hosts -m command -a "systemctl status mysql"
```

### Debug Mode
Run playbooks with increased verbosity:
```bash
ansible-playbook -i inventories/dev/hosts site.yml -vvv
```

## Contributing

1. Fork the repository
2. Create feature branch
3. Make changes with proper testing
4. Submit pull request with detailed description

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues and questions:
- Create GitHub issue with detailed description
- Include environment details and error messages
- Provide relevant log files
