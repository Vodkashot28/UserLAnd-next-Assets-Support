#!/bin/bash
SCRIPT_PATH=$(realpath ${BASH_SOURCE})
sudo rm -f $SCRIPT_PATH

if ! python3 -c "import onnxruntime" &>/dev/null; then
    sudo DEBIAN_FRONTEND=noninteractive apt -y update
    sudo DEBIAN_FRONTEND=noninteractive apt -y --no-install-recommends install python3-pip
    pip3 install onnxruntime
fi

python3 -c "import onnxruntime as ort; print('ONNX Runtime', ort.__version__, '— OK')"
