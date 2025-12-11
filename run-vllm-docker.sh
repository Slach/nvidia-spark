docker run -d --runtime nvidia --gpus all \
  --name vllm-openai \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  -p 8000:8000 \
  vllm/vllm-openai:latest \
  --model $1
