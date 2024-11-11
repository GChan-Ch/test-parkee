#!/bin/bash

# File log untuk mencatat informasi penggunaan CPU
LOG_FILE="/var/log/cpu_usage_monitor.log"

# Batas penggunaan CPU yang ditentukan (dalam persen)
CPU_THRESHOLD=75

# Fungsi untuk memonitor penggunaan CPU
monitor_cpu_usage() {
    # Mendapatkan penggunaan CPU rata-rata dalam 1 menit (idle CPU)
    CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    
    # Mengecek apakah penggunaan CPU melebihi batas threshold
    if (( $(echo "$CPU_IDLE > $CPU_THRESHOLD" | bc -l) )); then
        # Menyimpan informasi ke dalam log file
        echo "$(date) - High CPU usage detected: $CPU_IDLE% CPU used." >> "$LOG_FILE"
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

# Memanggil fungsi untuk memonitor penggunaan CPU
monitor_cpu_usage

# Menjalankan script ini terus-menerus setiap menit
while true; do
    sleep 60  # Menunggu selama 1 menit
    monitor_cpu_usage
done
