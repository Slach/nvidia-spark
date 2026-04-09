# AI HomeLab on NVIDIA DGX Spark

This project provides tools and configurations for setting up your own AI HomeLab using NVIDIA DGX Spark technology, featuring multiple LLM inference servers and AI-powered development tools.

## Overview

This repository contains scripts and Docker configurations for running multiple LLM inference servers on NVIDIA's GB10 DGX Spark GPU. The setup supports llama.cpp, vLLM, SGLang, and MAX inference servers, along with Claude Code Router and Vibe Kanban for AI-assisted development.

## Features

- Docker-based deployments with NVIDIA GPU support
- Multiple LLM inference servers: llama.cpp, vLLM, SGLang, MAX
- Optimized for NVIDIA GB10 DGX Spark
- Claude Code Router for intelligent model routing
- Vibe Kanban for AI-enhanced project management
- Support for long-context models (up to 1M tokens)
- Multiple quantization formats: FP8, MXFP4, Q4_K_M, Q8_0

## Quick Start

### Prerequisites

```bash
# Create spark network
docker network create spark-network

# Create .env file with required variables (see Environment Variables below)
```

### Start Inference Servers

```bash
# Start all services via Docker Compose
docker compose up -d

# View logs
docker compose logs -f
```

### Start Claude Code Router

```bash
./run-claude-code-router.sh
```

This will:
- Start the configured inference server (llama.cpp, vLLM, SGLang, or MAX)
- Configure Claude Code Router with local and remote model providers
- Start the router via `screen`

### Start Vibe Kanban

```bash
./run-vibe-kanban.sh
```

This will:
- Configure Vibe Kanban to use Claude Code Router
- Start Vibe Kanban via `screen`

## Inference Servers

| Service | Port | Description |
|---------|------|-------------|
| `llama.cpp` | 8090 | llama.cpp server with INI-based model config |
| `vllm` | 30001 | vLLM with fastsafetensors support |
| `sglang` | 30000 | SGLang inference server |
| `max-inference` | 8100 | MAX inference server |

## Models Supported

Models are configured in `llama.cpp.models.ini`:

### Active Models

- **mradermacher/Nemotron-Cascade-2-30B** - 60-70t/s generation, 2900t/s context parsing
- **unsloth/Qwen3.5-35B** - 49-51t/s generation, 1800-2500t/s context parsing
- **noctrex/Qwen3.5-35B** (MXFP4) - 39-50t/s generation, 1500-2000t/s context parsing
- **Exil01/Qwen3.5-35B-1M** - 1M context support with YaRN scaling
- **noctrex/Qwen3-Next-80B** - 1M context support
- **unsloth/GLM-4.7-Flash-30B** - Fast inference model
- **unsloth/Qwen3.5-27B** - 10t/s generation, 500t/s context parsing

### Additional Services

- **seer-marketing** (8889) - MX Seer marketing tools
- **aider-desk** (24337) - Aider IDE integration
- **b4** - Network tunneling tool

## Environment Variables

Create a `.env` file in the project root:

```bash
# Inference server selection
AGENT_INFERENCE_SERVER=llama.cpp        # llama.cpp, vllm, sglang, max-inference, openrouter, z-ai
AGENT_MAIN_MODEL=noctrex/Qwen3.5-35B
AGENT_BACKGROUND_MODEL=noctrex/Qwen3.5-35B

# Model paths
VLLM_MODEL=Qwen/Qwen3.5-35B-A3B-FP8
SGLANG_MODEL=Qwen/Qwen3.5-27B-FP8

# API keys
OPENROUTER_API_KEY=your_openrouter_api_key
DEEPSEEK_API_KEY=your_deepseek_api_key
ZAI_API_KEY=your_zai_api_key
HF_TOKEN=your_huggingface_token

# GitHub (for Vibe Kanban)
GITHUB_USER=your_github_username
GITHUB_EMAIL=your_github_email

# Port overrides
VIBE_KANBAN_PORT=8888
SEER_PORT=8889
AIDER_DESK_PORT=24337
```

## Claude Code Router Configuration

The router supports multiple providers with intelligent routing:

- **Local models** (llama.cpp, vLLM, SGLang, MAX) as primary
- **OpenRouter** for fallback and diverse model access
- **DeepSeek** for specific tasks
- **Z.AI** for GLM models

Router config is generated in `~/.claude-code-router/config.json`.

## Requirements

- NVIDIA GB10 DGX Spark (80GB VRAM)
- Docker and Docker Compose with NVIDIA Container Toolkit
- Bun JavaScript runtime (installed automatically)
- At least 64GB RAM recommended (128GB+ for large models)

## Ports

| Service | URL |
|---------|-----|
| llama.cpp | http://127.0.0.1:8090 |
| vLLM | http://127.0.0.1:30001 |
| SGLang | http://127.0.0.1:30000 |
| MAX | http://127.0.0.1:8100 |
| Vibe Kanban | http://127.0.0.1:8888 |
| Seer | http://127.0.0.1:8889 |
| Aider Desk | http://127.0.0.1:24337 |

## Scripts

- `run-claude-code-router.sh` - Start Claude Code Router
- `run-vibe-kanban.sh` - Start Vibe Kanban
- `download-hf-models.sh` - Download models from Hugging Face
- `build-vllm-cuda13-docker.sh` - Build vLLM Docker image
- `build-llama.cpp-cuda13-docker.sh` - Build llama.cpp Docker image
- `install-code-agents.sh` - Install code agent tools

## License

MIT License
