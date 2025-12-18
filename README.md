# AI HomeLab on NVIDIA DGX Spark

This project provides tools and configurations for setting up your own AI HomeLab using NVIDIA DGX Spark technology.

## Overview

This repository contains scripts and Docker configurations to help you create a powerful AI development environment using NVIDIA's GPU-accelerated computing platform. The setup is designed to leverage the capabilities of NVIDIA's DGX systems for local AI experimentation and development.

## Features

- Docker-based deployments for consistent environments
- Support for various AI frameworks and models
- Pre-configured scripts for common AI tasks
- Optimized for NVIDIA GPU acceleration

## Included Components

- Docker Compose configuration
- Llama.cpp integration for efficient inference
- vLLM (vLLM is fast and easy-to-use library for LLM inference) integration
- Hugging Face model support
- NVIDIA Docker runtime configuration

## Quick Start

Run any of the provided scripts to get started:

```bash
# For vLLM-based deployment
./run-vllm-docker.sh

# For Llama.cpp-based deployment
./run-llama.cpp-docker.sh

# For Hugging Face TGI deployment
./run-huggingface-tgi-docker.sh
```

## Requirements

- NVIDIA-compatible GPU with CUDA support
- Docker and Docker Compose
- NVIDIA Container Toolkit

## License

MIT License - See LICENSE file for details.