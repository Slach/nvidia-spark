
docker run --runtime nvidia --gpus all -p 8080:80 -v ~/.cache/huggingface:/root/.cache/huggingface ghcr.io/huggingface/text-generation-inference:latest --model-id "$1"