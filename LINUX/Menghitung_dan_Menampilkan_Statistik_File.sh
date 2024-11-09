#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Penggunaan: $0 <direktori>"
  exit 1
fi

direktori=$1

if [ ! -d "$direktori" ]; then
  echo "Direktori $direktori tidak ditemukan."
  exit 1
fi


printf "%-20s %-10s %-10s %-10s\n" "Nama File" "Baris" "Kata" "Karakter"
printf "%-20s %-10s %-10s %-10s\n" "----------" "-----" "----" "---------"

for file in "$direktori"/*.txt; do
  if [ -f "$file" ]; then
    jumlah_baris=$(wc -l < "$file")
    jumlah_kata=$(wc -w < "$file")
    jumlah_karakter=$(wc -m < "$file")
    printf "%-20s %-10s %-10s %-10s\n" "$(basename "$file")" "$jumlah_baris" "$jumlah_kata" "$jumlah_karakter"
  fi
done
