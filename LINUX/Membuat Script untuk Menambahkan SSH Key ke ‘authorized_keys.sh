#!/bin/bash

# Memeriksa apakah dua parameter diberikan
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <public_key_file> <username>"
    exit 1
fi

# Mendapatkan nilai parameter
PUBLIC_KEY_FILE="$1"
USERNAME="$2"

# Memeriksa apakah file public key ada
if [ ! -f "$PUBLIC_KEY_FILE" ]; then
    echo "Error: Public key file '$PUBLIC_KEY_FILE' does not exist."
    exit 1
fi

# Memeriksa apakah direktori .ssh ada untuk user yang bersangkutan
USER_SSH_DIR="/home/$USERNAME/.ssh"
if [ ! -d "$USER_SSH_DIR" ]; then
    echo "Directory $USER_SSH_DIR does not exist. Creating it now..."
    mkdir -p "$USER_SSH_DIR"
    chmod 700 "$USER_SSH_DIR"
fi

# Menambahkan public key ke file authorized_keys
AUTHORIZED_KEYS_FILE="$USER_SSH_DIR/authorized_keys"
if [ -f "$AUTHORIZED_KEYS_FILE" ]; then
    echo "Appending public key to $AUTHORIZED_KEYS_FILE..."
else
    echo "Creating $AUTHORIZED_KEYS_FILE..."
    touch "$AUTHORIZED_KEYS_FILE"
    chmod 600 "$AUTHORIZED_KEYS_FILE"
fi

# Menambahkan isi public key ke file authorized_keys
cat "$PUBLIC_KEY_FILE" >> "$AUTHORIZED_KEYS_FILE"
chmod 600 "$AUTHORIZED_KEYS_FILE"

# Memberi tahu pengguna bahwa proses selesai
echo "Public key has been successfully added to $USERNAME's authorized_keys."
