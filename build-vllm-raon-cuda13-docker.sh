#!/bin/bash
# KRAFTON Raon-1 mini vLLM image: krafton-ai/vllm fork (branch "raon") on top of the pinned
# upstream ARM64 binary wheel, see Dockerfile.vllm.raon.spark. No C++ compile step - the
# fork checkout is only a build context (Python sources + csrc for first-start JIT).
# The pinned wheel is downloaded on the host into docker/raon-spark/precompiled.whl
# (URL + SHA-256 from the fork's docker/raon-spark/README.md; in-docker curl stalls here).
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
KRAFTON_DIR="${HOME}/src/github.com/krafton-ai"
VLLM_DIR="${KRAFTON_DIR}/vllm"
VLLM_REF="${VLLM_REF:-raon}"
VLLM_WHEEL_URL='https://wheels.vllm.ai/53e211d2923192ea1f7442de93d59cfbb150e089/vllm-0.27.2rc1.dev151%2Bg53e211d29-cp38-abi3-manylinux_2_28_aarch64.whl'
VLLM_WHEEL_SHA='29cfdc2b966c72e7515807ad0fbdeda0c15db01599b58197b09bf8a095556ec6'

mkdir -p "${KRAFTON_DIR}"
git clone https://github.com/krafton-ai/vllm.git "${VLLM_DIR}" || true

cd "${VLLM_DIR}"
git checkout "${VLLM_REF}"
git pull
VLLM_COMMIT=$(git rev-parse HEAD)
rm -rf vllm/*.so vllm/vllm-rs build *.egg-info

cd -
WHEEL="${VLLM_DIR}/docker/raon-spark/precompiled.whl"
if ! echo "${VLLM_WHEEL_SHA}  ${WHEEL}" | sha256sum -c --status - 2>/dev/null; then
    curl -fL --retry 5 -C - "${VLLM_WHEEL_URL}" -o "${WHEEL}"
    echo "${VLLM_WHEEL_SHA}  ${WHEEL}" | sha256sum -c -
fi

docker pull vllm/vllm-openai@sha256:2a7cde230b59f3ce6cab33dd245ba6bee41aa87b38c9fe84f966ff24016813ce
docker build --progress=plain --platform=linux/arm64 \
    -f "${CUR_DIR}/Dockerfile.vllm.raon.spark" \
    --build-arg VLLM_REF="${VLLM_COMMIT}" \
    -t vllm:raon "${VLLM_DIR}"
