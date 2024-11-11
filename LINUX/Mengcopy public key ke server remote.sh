#!/bin/bash

# Memeriksa apakah tiga parameter diberikan
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <public_key_file> <username> <server_ip>"
    exit 1
fi

# Mendapatkan nilai parameter
PUBLIC_KEY_FILE="$1"
USERNAME="$2"
SERVER_IP="$3"

# Memeriksa apakah file public key ada
if [ ! -f "$PUBLIC_KEY_FILE" ]; then
    echo "Error: Public key file '$PUBLIC_KEY_FILE' does not exist."
    exit 1
fi

# Menyalin file public key ke server remote
echo "Copying public key to $USERNAME@$SERVER_IP:/home/$USERNAME/.ssh/authorized_keys..."

# Menggunakan SCP untuk menyalin public key ke server remote
scp "$PUBLIC_KEY_FILE" "$USERNAME@$SERVER_IP:/home/$USERNAME/.ssh/authorized_keys"

# Memeriksa status dari perintah SCP
if [ $? -eq 0 ]; then
    echo "Public key successfully copied to $USERNAME@$SERVER_IP:/home/$USERNAME/.ssh/authorized_keys"
else
    echo "Error: Failed to copy public key."
    exit 1
fi

# Memastikan izin yang benar pada file authorized_keys
ssh "$USERNAME@$SERVER_IP" "chmod 700 /home/$USERNAME/.ssh && chmod 600 /home/$USERNAME/.ssh/authorized_keys"

# Memeriksa status dari perintah SSH
if [ $? -eq 0 ]; then
    echo "Permissions for authorized_keys set correctly on the remote server."
else
    echo "Error: Failed to set permissions for authorized_keys."
    exit 1
fi
