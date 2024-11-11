#!/bin/bash

# Memeriksa apakah dua parameter diberikan
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <start|stop|status> <service_name>"
    exit 1
fi

# Mendapatkan nilai parameter
ACTION="$1"
SERVICE_NAME="$2"

# Memeriksa apakah tindakan yang diberikan valid
if [[ ! "$ACTION" =~ ^(start|stop|status)$ ]]; then
    echo "Error: Invalid action '$ACTION'. Valid actions are 'start', 'stop', or 'status'."
    exit 1
fi

# Memeriksa status dari service
check_status() {
    systemctl is-active --quiet "$SERVICE_NAME"
    if [ $? -eq 0 ]; then
        echo "Service '$SERVICE_NAME' is running."
    else
        echo "Service '$SERVICE_NAME' is not running."
    fi
}

# Memulai service
start_service() {
    echo "Starting service '$SERVICE_NAME'..."
    systemctl start "$SERVICE_NAME"
    if [ $? -eq 0 ]; then
        echo "Service '$SERVICE_NAME' started successfully."
    else
        echo "Failed to start service '$SERVICE_NAME'."
    fi
}

# Menghentikan service
stop_service() {
    echo "Stopping service '$SERVICE_NAME'..."
    systemctl stop "$SERVICE_NAME"
    if [ $? -eq 0 ]; then
        echo "Service '$SERVICE_NAME' stopped successfully."
    else
        echo "Failed to stop service '$SERVICE_NAME'."
    fi
}

# Menjalankan tindakan yang sesuai
case "$ACTION" in
    start)
        start_service
        ;;
    stop)
        stop_service
        ;;
    status)
        check_status
        ;;
esac
