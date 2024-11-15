#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Penggunaan: $0 <direktori> <ekstensi file>"
  exit 1
fi

direktori=$1
ekstensi=$2

if [ ! -d "$direktori" ]; then
  echo "Direktori $direktori tidak ditemukan."
  exit 1
fi

echo "Mencari file dengan ekstensi .$ekstensi di direktori $direktori:"
find "$direktori" -type f -name "*.$ekstensi" -print
