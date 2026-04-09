CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
mkdir -p ~/src/github.com/vllm-project/vllm
git clone git@github.com:vllm-project/vllm.git ~/src/github.com/vllm-project/vllm || true
export VLLM_RELEASE=$(curl -sL -H "Accept: application/json" https://github.com/vllm-project/vllm/releases/latest | jq -c -r .tag_name)

cd ~/src/github.com/vllm-project/vllm
git checkout .
git checkout main
git pull --tags
git checkout "${VLLM_RELEASE}"
CUDA_VERSION=13.0.2
UBUNTU_VERSION=$(grep 'VERSION_ID' /etc/os-release | cut -d'"' -f2)
docker pull vllm/vllm-openai:cu130-nightly-aarch64
docker build --progress=plain --platform=linux/arm64 -f "${CUR_DIR}/Dockerfile.vllm.spark" -t vllm:spark-full .
cd -