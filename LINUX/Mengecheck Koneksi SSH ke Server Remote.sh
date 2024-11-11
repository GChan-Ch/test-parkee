#!/bin/bash

# Memeriksa apakah dua parameter diberikan
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <username> <server_ip>"
    exit 1
fi

# Mendapatkan nilai parameter
USERNAME="$1"
SERVER_IP="$2"

# Mencoba koneksi SSH ke server remote
echo "Attempting SSH connection to $USERNAME@$SERVER_IP..."

# Menggunakan perintah ssh untuk mencoba koneksi
ssh -o BatchMode=yes -o ConnectTimeout=5 "$USERNAME@$SERVER_IP" exit

# Memeriksa status exit dari SSH
if [ $? -eq 0 ]; then
    echo "Connection to $USERNAME@$SERVER_IP was successful."
else
    echo "Failed to connect to $USERNAME@$SERVER_IP."
fi
