# AI HomeLab on NVIDIA DGX Spark

This project provides tools and configurations for setting up your own AI HomeLab using NVIDIA DGX Spark technology, featuring Claude Code Router and Vibe Kanban integration for enhanced AI development workflows.

## Overview

This repository contains scripts and Docker configurations to help you create a powerful AI development environment using NVIDIA's GPU-accelerated computing platform. The setup is designed to leverage the capabilities of NVIDIA's DGX systems for local AI experimentation and development, with integrated Claude Code Router and Vibe Kanban for advanced code-assisted workflows.

## Features

- Docker-based deployments for consistent environments
- Support for various AI frameworks and models
- Pre-configured scripts for common AI tasks
- Optimized for NVIDIA GPU acceleration
- Integrated Claude Code Router for AI-powered code assistance
- Vibe Kanban for AI-enhanced project management
- Docker Compose setup with health checks
- Multiple LLM model support via llama.cpp

## Included Components

- Docker Compose configuration with health checks
- Llama.cpp integration for efficient inference with CUDA support
- vLLM (vLLM is fast and easy-to-use library for LLM inference) integration
- Claude Code Router for AI-powered code assistance
- Vibe Kanban for AI-enhanced project management
- Hugging Face model support
- NVIDIA Docker runtime configuration
- Support for multiple large language models including Qwen3-Next-80B, MiniMax-M2-139B, and others

## Quick Start

### For Claude Code Router and Vibe Kanban setup:

```bash
# Make sure you have .env file with your API keys (see Environment Variables below)
./run-claude-code-router.sh
```

This will:
- Install Bun (if not already installed)
- Start the llama.cpp service via Docker Compose
- Install Claude Code Router, Claude Code, and Vibe Kanban
- Configure Claude Code Router with local and remote model providers
- Start the Claude Code Router server

### For standalone Docker Compose setup:

```bash
# Start both llama.cpp and vibe-kanban services
docker compose up -d

# View logs
docker compose logs -f
```

## Models Supported

The system supports various models configured in `llama.cpp.models.ini`:
- noctrex/MiniMax-M2-139B
- noctrex/Qwen3-Next-80B (with 1M context support)
- noctrex/Nemotron-3-Nano-30B
- unsloth/Devstral-2-139B-Instruct-2512-GGUF
- endyjasmi/Qwen3-Embedding-8B

## Environment Variables

Create a `.env` file in the project root with the following variables:

```bash
OPENROUTER_API_KEY=your_openrouter_api_key
DEEPSEEK_API_KEY=your_deepseek_api_key
GITHUB_USER=your_github_username
GITHUB_EMAIL=your_github_email
```

## Claude Code Router Configuration

The Claude Code Router is configured with:
- Local llama.cpp models as primary provider
- OpenRouter and DeepSeek as fallback providers
- Smart routing based on task complexity and context length
- Support for multiple AI models including Claude, Gemini, Grok, and others

## Requirements

- NVIDIA-compatible GPU with CUDA support
- Docker and Docker Compose
- NVIDIA Container Toolkit
- Bun JavaScript runtime
- At least 128GB RAM recommended for large models (e.g., 139B parameter models)

## License

MIT License - See LICENSE file for details.