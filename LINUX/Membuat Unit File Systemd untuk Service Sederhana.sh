#!/bin/bash

# Memeriksa apakah pengguna menjalankan script sebagai root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Mendefinisikan direktori dan nama file untuk script Python dan service
SERVICE_NAME="hello_world.service"
PYTHON_SCRIPT="/home/user/hello_world.py"
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME"

# Membuat file Python sederhana
echo "Creating Python script at $PYTHON_SCRIPT..."

cat <<EOL > "$PYTHON_SCRIPT"
#!/usr/bin/env python3
import time

# Menulis pesan ke log setiap 10 detik
while True:
    with open("/var/log/hello_world.log", "a") as log_file:
        log_file.write(f"Hello World at {time.ctime()}\n")
    time.sleep(10)
EOL

# Memberikan izin eksekusi pada script Python
chmod +x "$PYTHON_SCRIPT"

# Membuat file unit systemd untuk service
echo "Creating systemd service file at $SERVICE_FILE..."

cat <<EOL > "$SERVICE_FILE"
[Unit]
Description=Hello World Python Service
After=network.target

[Service]
ExecStart=/usr/bin/python3 $PYTHON_SCRIPT
Restart=always
User=user
Group=user

[Install]
WantedBy=multi-user.target
EOL

# Memuat ulang systemd untuk mengenali file unit baru
systemctl daemon-reload

# Mengaktifkan dan memulai service
echo "Enabling and starting the service..."
systemctl enable hello_world.service
systemctl start hello_world.service

# Menampilkan status service
echo "Service status:"
systemctl status hello_world.service

# Menyelesaikan
echo "Systemd service has been created, enabled, and started."
