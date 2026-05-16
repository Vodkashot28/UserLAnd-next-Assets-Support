#!/bin/bash
SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

if ! python3 -c "import torch" &>/dev/null; then
    sudo DEBIAN_FRONTEND=noninteractive apt -y update
    sudo DEBIAN_FRONTEND=noninteractive apt -y --no-install-recommends install python3-pip
    pip3 install torch --index-url https://download.pytorch.org/whl/cpu
fi

python3 -c "import torch; print('PyTorch', torch.__version__, '— CPU OK'); t=torch.rand(3,3); print(t)"
