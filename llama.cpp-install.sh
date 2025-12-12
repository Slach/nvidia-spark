# curl https://installama.sh | sh
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
mkdir -p ~/src/github.com/ggml-org/llama.cpp
git clone git@github.com:ggml-org/llama.cpp.git ~/src/github.com/ggml-org/llama.cpp
export LLAMA_CPP_RELEASE=$(curl -sL -H "Accept: application/json" https://github.com/ggml-org/llama.cpp/releases/latest | jq -c -r .tag_name)
cd ~/src/github.com/ggml-org/llama.cpp
git checkout master
git pull
git checkout "${LLAMA_CPP_RELEASE}"
# CUDA_VERSION=$(nvcc --version | grep release | cut -d "V" -f 2)
CUDA_VERSION=13.0.2
UBUNTU_VERSION=$(grep 'VERSION_ID' /etc/os-release | cut -d'"' -f2)
CUDA_DOCKER_ARCH=121
# docker build --platform=linux/arm64 -f .devops/cuda.Dockerfile --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg CUDA_VERSION=${CUDA_VERSION} --build-arg CUDA_DOCKER_ARCH=${CUDA_DOCKER_ARCH} --target full -t llama.cpp:spark-full .
docker build --platform=linux/arm64 -f "${CUR_DIR}/Dockerfile.llama.cpp.spark" --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg CUDA_VERSION=${CUDA_VERSION} --build-arg CUDA_DOCKER_ARCH=${CUDA_DOCKER_ARCH} --target full -t llama.cpp:spark-full .
cd -