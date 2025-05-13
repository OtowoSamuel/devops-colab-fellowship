# SSH Key Generation and Usage

This document provides instructions on how to generate and use SSH keys for secure access to the server.

## Generating SSH Keys

1. **Open a terminal** on your local machine.

2. **Generate a new SSH key pair** by running the following command:
   ```
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```
   Replace `your_email@example.com` with your email address. This command creates a new SSH key using the RSA algorithm with a key size of 4096 bits.

3. **Follow the prompts**:
   - You will be asked where to save the key. Press Enter to accept the default location (`~/.ssh/id_rsa`).
   - You can also set a passphrase for added security, or press Enter to leave it empty.

4. **Locate your public key**:
   Your public key will be saved in the file `~/.ssh/id_rsa.pub`.

## Copying the SSH Key to the Server

1. **Use the following command** to copy your public key to the server:
   ```
   ssh-copy-id username@server_ip
   ```
   Replace `username` with your server username and `server_ip` with the server's IP address.

2. **Enter your password** when prompted. This will add your public key to the `~/.ssh/authorized_keys` file on the server.

## Testing SSH Key Authentication

1. **Test the SSH connection** using your key:
   ```
   ssh username@server_ip
   ```
   If everything is set up correctly, you should be able to log in without being prompted for a password.

## Important Notes

- Keep your private key (`~/.ssh/id_rsa`) secure and never share it with anyone.
- If you set a passphrase, you will need to enter it each time you use the key.
- You can manage multiple SSH keys by specifying the key file when connecting:
  ```
  ssh -i /path/to/private_key username@server_ip
  ```