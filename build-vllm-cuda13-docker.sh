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