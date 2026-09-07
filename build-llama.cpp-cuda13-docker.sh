# curl https://installama.sh | sh
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${CUR_DIR}/.env"
mkdir -p ~/src/github.com/ggml-org/llama.cpp
git clone git@github.com:ggml-org/llama.cpp.git ~/src/github.com/ggml-org/llama.cpp || true
export LLAMA_CPP_RELEASE=$(curl -s -H "Accept: application/vnd.github+json" ${GITHUB_TOKEN:+-H "Authorization: Bearer $GITHUB_TOKEN"} "https://api.github.com/repos/ggml-org/llama.cpp/releases?per_page=100" | jq -r '[.[] | select(.draft == false) | .tag_name | select(test("^b[0-9]+$"))] | max_by(.[1:] | tonumber)')
cd ~/src/github.com/ggml-org/llama.cpp
git checkout master
git pull
git checkout "${LLAMA_CPP_RELEASE}"
# CUDA_VERSION=$( | grep release | cut -d "V" -f 2)
CUDA_VERSION=13.3.1
UBUNTU_VERSION=$(grep 'VERSION_ID' /etc/os-release | cut -d'"' -f2)
CUDA_DOCKER_ARCH=121
docker build --progress=plain --platform=linux/arm64 -f "${CUR_DIR}/Dockerfile.llama.cpp.spark" --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg CUDA_VERSION=${CUDA_VERSION} --build-arg CUDA_DOCKER_ARCH=${CUDA_DOCKER_ARCH} --target full -t llama.cpp:spark-full .
cd -