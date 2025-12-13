#!/bin/bash
docker run -d --runtime nvidia --gpus all \
  --name llama.cpp \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  -p 8090:8090 \
  --entrypoint /app/llama-server \
  llama.cpp:spark-full \
  "${@}"
