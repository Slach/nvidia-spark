# IST-DASLab/disaggregated-llama.cpp fork - offloaded disaggregated prefill (--odp-blocks)
# card https://huggingface.co/ISTA-DASLab/Qwen3.8-27B-NVFP4-prefiller
# NVFP4 prefill blocks are streamed from NVMe while the low-bit IQ*_S GGUF decoder stays in VRAM.
# Needs Blackwell FP4 MMA: GB10 (sm_121, this box) or RTX 50-series (sm_120) - 120a/121a PTX.
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${CUR_DIR}/.env"
mkdir -p ~/src/github.com/IST-DASLab/disaggregated-llama.cpp
git clone https://github.com/IST-DASLab/disaggregated-llama.cpp.git ~/src/github.com/IST-DASLab/disaggregated-llama.cpp || true
cd ~/src/github.com/IST-DASLab/disaggregated-llama.cpp
git checkout master
git pull
# same CUDA stack as the stock build (build-llama.cpp-cuda13-docker.sh)
CUDA_VERSION=13.3.1
UBUNTU_VERSION=$(grep 'VERSION_ID' /etc/os-release | cut -d'"' -f2)
CUDA_DOCKER_ARCH=121
# per model card: cmake -DLLAMA_BUILD_BORINGSSL=ON (TLS for cpp-httplib);
# BoringSSL needs a Go toolchain during the build -> NEED_GO=1
CMAKE_EXTRA_ARGS="-DLLAMA_BUILD_BORINGSSL=ON"
docker build --progress=plain --platform=linux/arm64 -f "${CUR_DIR}/Dockerfile.llama.cpp.spark" --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg CUDA_VERSION=${CUDA_VERSION} --build-arg CUDA_DOCKER_ARCH=${CUDA_DOCKER_ARCH} --build-arg CMAKE_EXTRA_ARGS=${CMAKE_EXTRA_ARGS} --build-arg NEED_GO=1 --target full -t disaggregated-llama.cpp:spark-full .
cd -
