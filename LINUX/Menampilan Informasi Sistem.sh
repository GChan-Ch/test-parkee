#!/bin/bash

# Menampilkan Nama Host
echo "Host Name: $(hostname)"

# Menampilkan Waktu Sistem Saat Ini
echo "Current System Time: $(date)"

# Menampilkan Jumlah Pengguna yang Sedang Login
echo "Number of Users Logged In: $(who | wc -l)"
