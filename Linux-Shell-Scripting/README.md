# 🚀 Week 1 Project: Server Setup Automation

This guide explains how to run the provided Bash script to automate server setup on Ubuntu/Debian systems.

---

## 1. Download the Script

1. Copy the `server-setup.sh` script content from the project repository or documentation.
2. Save it to your server filesystem:

   ```bash
   nano server-setup.sh
   # Paste the script content
   # Save and exit (Ctrl+O, Enter, Ctrl+X)
   ```

## 2. Make the Script Executable

Allow execution permissions on the script:

```bash
chmod +x server-setup.sh
```

## 3. Review Script Variables

Optionally, open the script in your editor and verify or modify variables:

* `NEW_USER`: the username to create.
* `PASSWORD`: initial password for the new user.
* `SOFTWARE`: list of packages to install (default: `apache2`, `nginx`, `mysql-server`).
* `CRON_SCHEDULE`: cron timing for updates.
* `UPDATE_COMMAND`: command to run on schedule.

```bash
nano server-setup.sh
```

## 4. Execute the Script

Run the script with root privileges:

```bash
sudo ./server-setup.sh
```

The script will:

* Create the specified user if it does not exist
* Update the package index
* Install Apache, Nginx, and MySQL if not present
* Configure a daily cron job for system updates

## 5. Verify Setup

1. **User**: Confirm the new user exists:

   ```bash
   id <NEW_USER>
   ```

2. **Services**: Check installed services:

   ```bash
   systemctl status apache2 nginx mysql
   ```

3. **Cron Job**: List cron entries for root:

   ```bash
   sudo crontab -l
   ```

---

