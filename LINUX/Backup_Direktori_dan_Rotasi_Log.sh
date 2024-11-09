#!/bin/bash

# Mendefinisikan direktori sumber dan tujuan
direktori_sumber="/home/folder"
direktori_tujuan="/home/backup"

# Memastikan direktori sumber ada
if [ ! -d "$direktori_sumber" ]; then
  echo "Direktori sumber $direktori_sumber tidak ditemukan."
  exit 1
fi

# Memastikan direktori tujuan ada, jika tidak, buat direktori tujuan
if [ ! -d "$direktori_tujuan" ]; then
  mkdir -p "$direktori_tujuan"
fi

# Membuat nama file backup dengan timestamp
tanggal=$(date +"%Y%m%d")
nama_backup="backup_$(basename "$direktori_sumber")_$tanggal.tar.gz"

# Melakukan backup dan kompresi
echo "Mem-backup direktori $direktori_sumber ke $direktori_tujuan/$nama_backup"
tar -czf "$direktori_tujuan/$nama_backup" -C "$direktori_sumber" .

# Mengecek apakah backup berhasil
if [ $? -eq 0 ]; then
  echo "Backup berhasil disimpan di $direktori_tujuan/$nama_backup"
else
  echo "Backup gagal."
  exit 1
fi

# Menghapus backup yang lebih lama dari 7 hari
echo "Menghapus backup yang lebih lama dari 7 hari di direktori $direktori_tujuan"
find "$direktori_tujuan" -type f -name "backup_$(basename "$direktori_sumber")_*.tar.gz" -mtime +7 -exec rm -f {} \;

echo "Proses backup selesai."
