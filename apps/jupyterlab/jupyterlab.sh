#!/bin/bash
SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

if ! command -v jupyter &>/dev/null; then
    sudo DEBIAN_FRONTEND=noninteractive apt -y update
    sudo DEBIAN_FRONTEND=noninteractive apt -y --no-install-recommends install python3-pip
    pip3 install jupyterlab
fi

jupyter lab --ip=0.0.0.0 --no-browser --NotebookApp.token=''
