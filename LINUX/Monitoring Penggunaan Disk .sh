#!/bin/bash

# Persentase batas penggunaan disk
DISK_THRESHOLD=80

# Lokasi file log untuk mencatat penggunaan disk
LOG_FILE="/var/log/disk_usage_monitor.log"

# Fungsi untuk memonitor penggunaan disk
monitor_disk_usage() {
    # Mendapatkan persentase penggunaan disk untuk sistem root (/)
    DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//')

    # Mengecek apakah penggunaan disk melebihi batas threshold
    if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
        # Mencatat ke file log
        echo "$(date) - High disk usage detected: $DISK_USAGE% usage on /" >> "$LOG_FILE"
        
        # Mengirimkan notifikasi menggunakan notify-send (untuk sistem berbasis desktop)
        notify-send "Warning: High Disk Usage" "Disk usage is at $DISK_USAGE%, exceeding the threshold of $DISK_THRESHOLD%!"
        
        # Anda bisa menggunakan metode notifikasi lain seperti mengirim email atau Slack jika diperlukan.
    fi
}

# Memastikan direktori log ada dan file log dapat diakses
if [ ! -d "/var/log" ]; then
    echo "Log directory does not exist. Creating it."
    mkdir -p /var/log
fi

if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
    chmod 666 "$LOG_FILE"
fi

# Memanggil fungsi untuk memonitor penggunaan disk
monitor_disk_usage

# Menjalankan script ini terus-menerus setiap 10 menit
while true; do
    sleep 600  # Menunggu selama 10 menit
    monitor_disk_usage
done
