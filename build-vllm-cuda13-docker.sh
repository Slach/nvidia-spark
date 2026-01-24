CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
mkdir -p ~/src/github.com/vllm-project/vllm
git clone git@github.com:vllm-project/vllm.git ~/src/github.com/vllm-project/vllm
export VLLM_RELEASE=$(curl -sL -H "Accept: application/json" https://github.com/vllm-project/vllm/releases/latest | jq -c -r .tag_name)
# wait when 0.13.x released
# export VLLM_RELEASE=master

cd ~/src/github.com/vllm-project/vllm
git checkout .
git checkout main
git pull --tags
git checkout "${VLLM_RELEASE}"
# CUDA_VERSION=$(nvcc --version | grep release | cut -d "V" -f 2)
CUDA_VERSION=13.0.2
UBUNTU_VERSION=$(grep 'VERSION_ID' /etc/os-release | cut -d'"' -f2)
docker build --progress=plain --platform=linux/arm64 -f "${CUR_DIR}/Dockerfile.vllm.spark" --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg CUDA_VERSION=${CUDA_VERSION} --target vllm-base -t vllm:spark-full .
cd -