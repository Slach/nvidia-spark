#!/bin/bash
sudo apt install -y cuda-nvrtc-dev-13-2 libcublas-dev-13-2 libcurand-dev-13-2 cuda-libraries-dev-13-2
sudo apt install -y python3-pip python3.12-dev python3.12-venv pipx build-essential ninja-build cmake
pipx install uv
git clone git@github.com:vllm-project/vllm.git ~/src/github.com/vllm-project/vllm/ || true
cd ~/src/github.com/vllm-project/vllm/
git checkout .
git checkout main 
git pull
git checkout $(curl -sL -H "Accept: application/json" https://github.com/vllm-project/vllm/releases/latest | jq -c -r .tag_name)
uv venv --python python3.12 --allow-existing
source ./.venv/bin/activate
export UV_CONCURRENT_DOWNLOADS=2
export UV_HTTP_RETRIES=10
uv pip install -r requirements/build/cuda.txt -r requirements/cuda.txt --torch-backend cu130
export CUDA_HOME=/usr/local/cuda-13.2/
export TORCH_CUDA_ARCH_LIST="12.0f"
export VLLM_TARGET_DEVICE=cuda
export VLLM_CUDA_VERSION="13.2"
export MAX_JOBS=$(nproc)  
uv pip install -e . --no-build-isolation -v
cd -
	  