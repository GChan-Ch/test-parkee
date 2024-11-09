#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Penggunaan: $0 <direktori_sumber> <lokasi_backup>"
  exit 1
fi

direktori_sumber=$1
lokasi_backup=$2

if [ ! -d "$direktori_sumber" ]; then
  echo "Direktori sumber $direktori_sumber tidak ditemukan."
  exit 1
fi

nama_backup="backup_$(basename "$direktori_sumber").tar.gz"
echo "Mem-backup direktori $direktori_sumber ke $lokasi_backup/$nama_backup"
tar -czf "$lokasi_backup/$nama_backup" -C "$direktori_sumber" .

if [ $? -eq 0 ]; then
  echo "Backup berhasil disimpan di $lokasi_backup/$nama_backup"
else
  echo "Backup gagal."
  exit 1
fi
