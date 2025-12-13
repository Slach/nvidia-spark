#!/bin/bash
docker run -d --runtime nvidia --gpus all \
  --name llama.cpp \
  -p 8080:80 \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  ghcr.io/huggingface/text-generation-inference:latest --model-id "$1"