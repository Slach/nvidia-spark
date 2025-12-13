#!/bin/bash
sudo apt install -y python3-pip python3.12-dev python3.12-venv pipx build-essential ninja-build cmake
pipx install uv
git clone git@github.com:vllm-project/vllm.git ~/src/github.com/vllm-project/vllm/
cd ~/src/github.com/vllm-project/vllm/
git checkout .
git checkout main 
git pull
# git checkout $(curl -sL -H "Accept: application/json" https://github.com/vllm-project/vllm/releases/latest | jq -c -r .tag_name)
uv venv --allow-existing
source ./.venv/bin/activate
uv pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu130
python use_existing_torch.py
uv pip install -r requirements/build.txt
export TORCH_CUDA_ARCH_LIST="12.1"
export VLLM_TARGET_DEVICE=cuda
export MAX_JOBS=$(nproc)  
export CMAKE_ARGS="-DCMAKE_CUDA_ARCHITECTURES=121"  
export VLLM_CUDA_VERSION="13.0"
uv pip install -e . --no-build-isolation -v
cd -
	  