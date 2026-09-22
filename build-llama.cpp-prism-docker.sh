#!/bin/bash
# PrismML-Eng llama.cpp fork (ternary Bonsai kernels: PQ2_0/PTQ1_0 ggml types 142/143,
# Hadamard activation runtime). Stock llama.cpp rejects these quants - see
# https://github.com/ggml-org/llama.cpp/issues/29058 (no upstream PR merged yet).
# CUDA release binaries are x64-only, GB10 needs aarch64 + sm_121a -> build from source.
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${CUR_DIR}/.env"
mkdir -p ~/src/github.com/PrismML-Eng
git clone https://github.com/PrismML-Eng/llama.cpp.git ~/src/github.com/PrismML-Eng/llama.cpp || \
  (cd ~/src/github.com/PrismML-Eng/llama.cpp && git fetch --tags)
# pin latest release tag of the prism branch (same policy as build-llama.cpp-cuda13-docker.sh)
export PRISM_LLAMA_CPP_RELEASE=$(curl -s -H "Accept: application/vnd.github+json" ${GITHUB_TOKEN:+-H "Authorization: Bearer $GITHUB_TOKEN"} "https://api.github.com/repos/PrismML-Eng/llama.cpp/releases?per_page=1" | jq -r '.[0].tag_name')
cd ~/src/github.com/PrismML-Eng/llama.cpp
git checkout prism
git pull
git checkout "${PRISM_LLAMA_CPP_RELEASE}"
echo "building PrismML llama.cpp ${PRISM_LLAMA_CPP_RELEASE}"
CUDA_VERSION=13.3.1
UBUNTU_VERSION=$(grep 'VERSION_ID' /etc/os-release | cut -d'"' -f2)
CUDA_DOCKER_ARCH=121
docker build --progress=plain --platform=linux/arm64 -f "${CUR_DIR}/Dockerfile.llama.cpp.spark" --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg CUDA_VERSION=${CUDA_VERSION} --build-arg CUDA_DOCKER_ARCH=${CUDA_DOCKER_ARCH} --target full -t llama.cpp:prism-full .
cd -
