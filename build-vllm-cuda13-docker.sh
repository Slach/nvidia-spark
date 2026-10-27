CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
VLLM_DIR="${HOME}/src/github.com/vllm-project/vllm"
mkdir -p "${VLLM_DIR}"
git clone git@github.com:vllm-project/vllm.git "${VLLM_DIR}" || true
export VLLM_RELEASE=$(curl -sL -H "Accept: application/json" https://github.com/vllm-project/vllm/releases/latest | jq -c -r .tag_name)

cd "${VLLM_DIR}"
git checkout .
git checkout main
git pull --tags
git checkout "${VLLM_RELEASE}"
rm -rf .deps .venv build *.egg-info

docker pull vllm/vllm-openai:cu130-nightly-aarch64
docker build --progress=plain --platform=linux/arm64 -f "${CUR_DIR}/Dockerfile.vllm.spark" -t vllm:spark-full "${VLLM_DIR}"
cd -

# Recursive Flint (vllm PR #62938): flint target = official flint-arm64-cu130 image + gguf
# pip package (the image predates the 826fd3f fix, see Dockerfile.vllm.spark). Fast single
# layer, does not need the vllm source checkout - repo dir is just a build context
docker pull vllm/vllm-openai:flint-arm64-cu130
docker build --progress=plain --platform=linux/arm64 -f "${CUR_DIR}/Dockerfile.vllm.spark" --target flint -t vllm:flint "${CUR_DIR}"

# chisel (yuanlin2004/chisel-spark-recipes chisel-nvfp4-dflash2-replay, 65.1 t/s decode):
# pinned spark-arena vLLM nightly + chisel-passes plugin layer, see Dockerfile.vllm.spark
# chisel target. Single layer on top of the pulled digest, no vllm checkout needed
docker pull ghcr.io/spark-arena/dgx-vllm-eugr-nightly@sha256:b77010699ec42ab88b3409f4dd101f2288dfd8895e2778e5bb737e03a20953f0
docker build --progress=plain --platform=linux/arm64 -f "${CUR_DIR}/Dockerfile.vllm.spark" --target chisel -t vllm:chisel "${CUR_DIR}"