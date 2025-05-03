#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# === Variables ===
NEW_USER="devopsuser"
PASSWORD="P@ssw0rd123"    
CRON_SCHEDULE="0 2 * * *"
UPDATE_COMMAND="apt update && apt upgrade -y"

# === Create new user ===
echo "Creating user: $NEW_USER"
if id "$NEW_USER" &>/dev/null; then
    echo "User $NEW_USER already exists. Skipping creation."
else
    useradd -m -s /bin/bash "$NEW_USER"
    echo "$NEW_USER:$PASSWORD" | chpasswd
    echo "User $NEW_USER created successfully."
fi

# === Install software ===
echo "Updating package index..."
apt update -y

SOFTWARE=("apache2" "nginx" "mysql-server")

echo "Installing software: ${SOFTWARE[*]}"
for pkg in "${SOFTWARE[@]}"; do
    if dpkg -s "$pkg" &>/dev/null; then
        echo "$pkg is already installed."
    else
        apt install -y "$pkg"
        echo "$pkg installed."
    fi
done

# === Setup cron via /etc/cron.d ===
echo "Creating /etc/cron.d/daily-system-update"
cat <<EOF | sudo tee /etc/cron.d/daily-system-update > /dev/null
# Run system updates daily at 02:00
0 2 * * * root apt update && apt upgrade -y
EOF
sudo chmod 644 /etc/cron.d/daily-system-update


# Check if the cron job already exists
CRON_JOB="$CRON_SCHEDULE $UPDATE_COMMAND"
(crontab -l 2>/dev/null | grep -v -F "$UPDATE_COMMAND" ; echo "$CRON_JOB") | crontab -

echo "Cron job set: $CRON_JOB"

echo "✅ Server setup complete."
