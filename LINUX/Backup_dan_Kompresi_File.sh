#!/bin/bash
backup="/home/folder"
dest="/mnt/backup"
day=$(date +%A)
hostname=$(hostname -s)
archive="$hostname-$day.tgz
tar czf $dest/$archive $backup
echo "Backup finished"
