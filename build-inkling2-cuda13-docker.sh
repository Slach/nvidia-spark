#!/bin/bash
# Unsloth llama.cpp fork image for Inkling 2 Mini (root looped-layout GGUFs + DSpark).
# No compile step - ships the unslothai prebuilt portable binary (see Dockerfile.Inkling2-Mini.spark).
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${CUR_DIR}/.env"
UBUNTU_VERSION=$(grep 'VERSION_ID' /etc/os-release | cut -d'"' -f2)
CUDA_VERSION=13.3.1
docker build --progress=plain --platform=linux/arm64 \
  -f "${CUR_DIR}/Dockerfile.Inkling2-Mini.spark" \
  --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} \
  --build-arg CUDA_VERSION=${CUDA_VERSION} \
  -t llama.cpp:inkling2-spark "${CUR_DIR}"
