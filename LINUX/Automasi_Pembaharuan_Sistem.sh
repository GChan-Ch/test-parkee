#!/bin/bash

LOGFILE="/var/log/update_system.log"
DATE=$(date "+%Y-%m-%d %H:%M:%S")


echo "[$DATE] Starting system update..." >> $LOGFILE
echo "[$DATE] Updating repository metadata..." >> $LOGFILE
sudo yum check-update >> $LOGFILE 2>&1

echo "[$DATE] Starting package updates..." >> $LOGFILE
sudo yum update -y >> $LOGFILE 2>&1

echo "[$DATE] Removing unnecessary packages..." >> $LOGFILE
sudo yum autoremove -y >> $LOGFILE 2>&1

DATE_FINISH=$(date "+%Y-%m-%d %H:%M:%S")
echo "[$DATE_FINISH] System update completed." >> $LOGFILE
