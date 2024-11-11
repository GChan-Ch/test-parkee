#!/bin/bash

# Memeriksa apakah script dijalankan dengan hak akses root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Mengatur nama file konfigurasi netplan (umumnya di /etc/netplan/)
NETPLAN_CONFIG="/etc/netplan/01-netcfg.yaml"

# Membuat file konfigurasi netplan untuk interface eth0
echo "Creating netplan configuration for eth0..."

cat > "$NETPLAN_CONFIG" <<EOL
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOL

# Menerapkan konfigurasi netplan
echo "Applying network configuration..."
netplan apply

# Menampilkan konfigurasi jaringan yang baru
echo "Network configuration applied:"
ip a show eth0
