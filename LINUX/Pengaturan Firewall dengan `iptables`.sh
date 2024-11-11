#!/bin/bash

# Memeriksa apakah script dijalankan dengan hak akses root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Menampilkan pesan yang akan dijalankan
echo "Configuring firewall with iptables..."

# Reset semua aturan iptables yang ada (opsional, hanya jika ingin menghapus aturan yang ada)
iptables -F           # Flush semua aturan yang ada
iptables -X           # Hapus chain yang ada

# Mengizinkan semua koneksi keluar
iptables -P OUTPUT ACCEPT

# Mengizinkan koneksi masuk ke port 22 (SSH), 80 (HTTP), dan 443 (HTTPS)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # SSH
iptables -A INPUT -p tcp --dport 80 -j ACCEPT  # HTTP
iptables -A INPUT -p tcp --dport 443 -j ACCEPT # HTTPS

# Menolak semua koneksi masuk lainnya
iptables -P INPUT DROP

# Menampilkan status aturan iptables yang telah diterapkan
echo "Firewall rules have been applied:"
iptables -L
