## Summary
This PR adds a Dockerfile and docker-compose service for Vibe Kanban to integrate with the existing nvidia-spark environment.

## Changes Made
- Created Dockerfile.vibe-kanban based on docker.io/oven/bun:latest
- Added vibe-kanban service to docker-compose.yaml with proper configuration
- Set up build process with vibe-kanban:spark tag
- Implemented proper runtime execution with screen sessions for both ccr-server and vibe-kanban
- Configured volume mount to share host home directory
- Set up port forwarding for port 8888
- Integrated with the existing llama.cpp service and spark network
- Added proper Claude Code Router configuration with llama.cpp, openrouter, and deepseek providers
- Created external startup script at docker/run-vibe-kanban.sh
- Added proper environment variable sourcing and service dependency management

## Implementation Details
- The Dockerfile installs required dependencies (screen, curl, git, netcat)
- Uses external startup script for better maintainability
- Properly waits for llama.cpp service before starting
- Configures Claude Code Router to use llama.cpp:8090 as primary provider with openrouter and deepseek as fallbacks
- Creates necessary directories and configuration files
- Properly handles existing screen sessions before starting new ones
- Routes web traffic through port 8888 for the Vibe Kanban application

## Motivation
This integration allows users to run Vibe Kanban alongside the existing AI infrastructure, providing a comprehensive development environment with Claude Code Router and multiple AI providers.

This PR was written using [Vibe Kanban](https://vibekanban.com)