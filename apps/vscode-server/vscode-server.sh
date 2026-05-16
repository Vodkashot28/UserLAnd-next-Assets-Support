#!/bin/bash
SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

if ! command -v code-server &>/dev/null; then
    curl -fsSL https://code-server.dev/install.sh | sh
fi

code-server --bind-addr 0.0.0.0:8080 --auth none
