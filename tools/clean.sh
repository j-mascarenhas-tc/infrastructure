#!/bin/bash

#Clean APT cache
apt clean -y

#Remove unused dependencies
apt autoremove --purge -y

#Remove temporary files
rm -rf /var/tmp/*

#Remove old log files
find /var/log \( -iname "*.old" -o -iname "*.gz" -o -iname "*.xz" -o -iname "*.1" \) -delete
