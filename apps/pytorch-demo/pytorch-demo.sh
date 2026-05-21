#!/bin/bash
SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

# Safe check to verify environment context integrity
if ! python3 -c "import torch" &>/dev/null; then
    echo "PyTorch missing from base layer. Running emergency local fallback fallback..."
    sudo DEBIAN_FRONTEND=noninteractive apt -y update
    sudo DEBIAN_FRONTEND=noninteractive apt -y --no-install-recommends install python3-pip
    pip3 install torch --index-url https://download.pytorch.org/whl/cpu
fi

# Execute explicit smoke test
clear
echo "=================================================="
echo "    UserLAnd-Next: PyTorch Engine Active          "
echo "=================================================="
python3 -c "import torch; print('Engine Version:', torch.__version__); print('\nGenerating Test Tensor (3x3 matrix):'); t=torch.rand(3,3); print(t)"
echo "=================================================="

