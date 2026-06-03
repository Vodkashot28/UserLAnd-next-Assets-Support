#!/bin/bash
SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

CONFIG_URL="https://raw.githubusercontent.com/Vodkashot28/ZenCode-server/Master/assets/default_config.json"
RELEASE_URL="https://github.com/Vodkashot28/ZenCode-server/releases/latest/download/zencode-assets-arm64.tar.gz"

echo "📥 Pulling latest ZenCode-Server binary from GitHub..."
curl -L "$RELEASE_URL" -o /tmp/zencode-assets.tar.gz
tar -xzf /tmp/zencode-assets.tar.gz -C /usr/local/
chmod +x /usr/local/bin/zencode-server
chmod +x /usr/local/bin/zencode-dashboard 2>/dev/null || true

echo "📄 Syncing default config from Master branch..."
mkdir -p /usr/local/etc/zencode-server
curl -sL "$CONFIG_URL" -o /usr/local/etc/zencode-server/default_config.json

echo "✅ ZenCode-Server installed. Run 'zencode-server' to start."
