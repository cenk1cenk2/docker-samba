#!/bin/bash

# Treat unset variables as an error
set -o nounset

SEPERATOR="--------------------"

# SAMBA SCRIPT START
echo -e "Starting SAMBA/CIFS Server...\n${SEPERATOR}"

# Create arguments string
# Enable NMBD
ARGUMENTS="-n"
# Server Name
ARGUMENTS="${ARGUMENTS} -g \"netbios name = \"${SRVNAME}\"\""
# Workgroup Name
ARGUMENTS="${ARGUMENTS} -w \"${WORKGROUPNAME}\""
# Parse and split Users by :
while IFS=':' read -ra TEMP; do
  for i in "${TEMP[@]}"; do
    ARGUMENTS="${ARGUMENTS} -u \"${i}\""
  done
done <<<"${USERS}"
# Parse and split Mounts by :
while IFS=':' read -ra TEMP; do
  for i in "${TEMP[@]}"; do
    ARGUMENTS="${ARGUMENTS} -s \"${i}\""
  done
done <<<"${MOUNTS}"

# Call the helper script
eval /samba.sh "${ARGUMENTS}" &

while
  smbclient -L '\\localhost' -U '%' -m SMB3 >&/dev/null
  :
do
  echo -e "${SEPERATOR}\nSamba server still running and healthy.\nSleeping 10 minutes.\n${SEPERATOR}"
  sleep 600
done
