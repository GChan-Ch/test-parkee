#!/bin/bash

# Memeriksa apakah dua parameter diberikan
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <unique_string> <username>"
    exit 1
fi

# Mendapatkan nilai parameter
UNIQUE_STRING="$1"
USERNAME="$2"

# Memeriksa apakah file authorized_keys ada untuk user yang bersangkutan
AUTHORIZED_KEYS_FILE="/home/$USERNAME/.ssh/authorized_keys"

if [ ! -f "$AUTHORIZED_KEYS_FILE" ]; then
    echo "Error: $AUTHORIZED_KEYS_FILE does not exist."
    exit 1
fi

# Mencari dan menghapus public key yang mengandung string unik
echo "Removing public key containing '$UNIQUE_STRING' from $AUTHORIZED_KEYS_FILE..."

# Menggunakan sed untuk menghapus baris yang mengandung string unik
sed -i "/$UNIQUE_STRING/d" "$AUTHORIZED_KEYS_FILE"

# Memeriksa apakah proses penghapusan berhasil
if [ $? -eq 0 ]; then
    echo "Public key containing '$UNIQUE_STRING' has been successfully removed."
else
    echo "Error: Failed to remove public key containing '$UNIQUE_STRING'."
    exit 1
fi
