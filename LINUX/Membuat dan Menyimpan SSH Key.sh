#!/bin/bash

# Mengecek apakah parameter direktori diberikan
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Direktori untuk menyimpan SSH key (diambil dari parameter pertama)
KEY_DIR="$1"

# Nama file untuk SSH key (tanpa ekstensi)
KEY_NAME="id_rsa"

# Memeriksa apakah direktori ada, jika tidak maka buat direktori
if [ ! -d "$KEY_DIR" ]; then
    echo "Directory $KEY_DIR does not exist. Creating it now..."
    mkdir -p "$KEY_DIR"
fi

# Menentukan path penuh untuk SSH key
PRIVATE_KEY_PATH="$KEY_DIR/$KEY_NAME"
PUBLIC_KEY_PATH="$PRIVATE_KEY_PATH.pub"

# Membuat pasangan SSH key menggunakan ssh-keygen
echo "Generating SSH key pair in directory $KEY_DIR..."
ssh-keygen -t rsa -b 4096 -f "$PRIVATE_KEY_PATH" -N "" 

# Memeriksa apakah ssh-keygen berhasil
if [ $? -eq 0 ]; then
    echo "SSH key pair generated successfully:"
    echo "Private key: $PRIVATE_KEY_PATH"
    echo "Public key: $PUBLIC_KEY_PATH"
else
    echo "Error: Failed to generate SSH key pair."
    exit 1
fi
