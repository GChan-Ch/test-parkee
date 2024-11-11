#!/bin/bash

# Memeriksa apakah tiga parameter diberikan
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <source_file> <username> <destination_ip>"
    exit 1
fi

# Mendapatkan nilai parameter
SOURCE_FILE="$1"
USERNAME="$2"
DEST_IP="$3"

# Memeriksa apakah file sumber ada
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Source file '$SOURCE_FILE' does not exist."
    exit 1
fi

# Menyalin file menggunakan rsync ke direktori home pengguna di server remote
echo "Syncing '$SOURCE_FILE' to $USERNAME@$DEST_IP:/home/$USERNAME/..."
rsync -avz "$SOURCE_FILE" "$USERNAME@$DEST_IP:/home/$USERNAME/"

# Memeriksa status exit dari perintah rsync
if [ $? -eq 0 ]; then
    echo "File successfully synced to $USERNAME@$DEST_IP:/home/$USERNAME/"
else
    echo "Error: Failed to sync file using rsync."
    exit 1
fi