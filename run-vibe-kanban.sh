#!/bin/bash
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
docker compose -f "${CUR_DIR}/docker-compose.yaml" up -d llama.cpp
bash "$CUR_DIR/install-bun.sh"
npx vibe-kanban@latest
