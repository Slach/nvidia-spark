docker run -d --runtime nvidia --gpus all \
  --name vllm-openai \
  -v ~/.cache/huggingface:/root/.cache/huggingface:ro \
  -p 8000:8000 \
  vllm/vllm-openai:full-spark \
  "${@}"
