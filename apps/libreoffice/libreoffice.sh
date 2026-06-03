#!/bin/bash
SCRIPT_PATH=$(realpath "${BASH_SOURCE}")
rm -f "$SCRIPT_PATH"

if [ ! -f /usr/bin/libreoffice ]; then
   DEBIAN_FRONTEND=noninteractive apt -y update
   DEBIAN_FRONTEND=noninteractive apt -y --no-install-recommends install libreoffice
   if [[ $? != 0 ]]; then
      read -rsp $'An error occurred installing packages, please try again and if it persists provide this log to the developer.\nPress any key to close...\n' -n1 key
      exit
   fi
fi

libreoffice
exit