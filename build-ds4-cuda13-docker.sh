CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
mkdir -p ~/src/github.com/antirez/ds4
git clone git@github.com:antirez/ds4.git ~/src/github.com/antirez/ds4 || true
cd ~/src/github.com/antirez/ds4
git checkout main
git pull
./download_model.sh ds4f-q2-q4
./download_model.sh ds4f-dspark
# wait when merge https://github.com/antirez/ds4/pull/594
# ./download_model.sh laguna-q4
# ./download_model.sh laguna-q2-q3
# ./download_model.sh laguna-dflash

mkdir -p ${HOME}/.cache/huggingface/hub/models--antirez-ds4/blobs/
ln -sf ${HOME}/src/github.com/antirez/ds4/gguf ${HOME}/.cache/huggingface/hub/models--antirez-ds4/blobs/latest
mkdir -p ${HOME}/.cache/huggingface/hub/models--antirez-ds4/snapshots/
ln -sf ${HOME}/src/github.com/antirez/ds4/gguf ${HOME}/.cache/huggingface/hub/models--antirez-ds4/blobs/latest

CUDA_VERSION=13.3.1
UBUNTU_VERSION=$(grep 'VERSION_ID' /etc/os-release | cut -d'"' -f2)
CUDA_DOCKER_ARCH=sm_121
cp .gitignore .dockerignore
docker build --progress=plain --platform=linux/arm64 -f "${CUR_DIR}/Dockerfile.ds4.spark" --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg CUDA_VERSION=${CUDA_VERSION} --build-arg CUDA_DOCKER_ARCH=${CUDA_DOCKER_ARCH} --target full -t ds4:spark-full .
cd -