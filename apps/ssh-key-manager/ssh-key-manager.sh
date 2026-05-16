#!/bin/bash
SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

echo "=== SSH Key Manager ==="
echo "1) Generate new key  2) List keys  3) Copy public key"
read -rp "Choice: " choice
case $choice in
  1) ssh-keygen -t ed25519 -C "userland-next" ;;
  2) ls -la ~/.ssh/*.pub 2>/dev/null || echo "No keys found." ;;
  3) cat ~/.ssh/id_ed25519.pub 2>/dev/null || echo "No ed25519 key found." ;;
  *) echo "Invalid choice." ;;
esac
