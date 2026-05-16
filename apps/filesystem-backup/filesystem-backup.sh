#!/bin/bash
SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

BACKUP_DIR="/sdcard/UserLAnd-Next-Backups"
mkdir -p "$BACKUP_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
ARCHIVE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

echo "Creating backup at $ARCHIVE ..."
tar -czf "$ARCHIVE" --exclude=/proc --exclude=/sys --exclude=/dev / 2>/dev/null
echo "Done: $ARCHIVE"
