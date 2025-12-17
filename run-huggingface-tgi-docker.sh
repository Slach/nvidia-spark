#!/bin/bash
docker run -d --runtime nvidia --gpus all \
  --name huggingface-tgi \
  -p 8080:80 \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  ghcr.io/huggingface/text-generation-inference:latest "${@}"