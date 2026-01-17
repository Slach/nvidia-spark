#!/bin/bash
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${CUR_DIR}/.env"

bash "$CUR_DIR/install-bun.sh"
if [[ "max-inference" == "${AGENT_INFERENCE_SERVER}" ]]; then
  mkdir -p ~/.cache/max_cache
fi

if [[ "openrouter" != "${AGENT_INFERENCE_SERVER}" ]]; then
  docker compose -f "$CUR_DIR/docker-compose.yaml" up -d ${AGENT_INFERENCE_SERVER}
fi 

mkdir -p ~/.claude-code-router
cat <<EOT > ~/.claude-code-router/config.json
{
  "LOG": false,
  "API_TIMEOUT_MS": 600000,
  "NON_INTERACTIVE_MODE": false,
  "Providers": [
    {
      "name": "max-inference",
      "api_base_url": "http://127.0.0.1:8100/v1/chat/completions",
      "api_key": "max-inference",
      "models": ["noctrex/MiniMax-M2-REAP-139B-A10B-MXFP4_MOE-GGUF"]
    },
    {
      "name": "llama.cpp",
      "api_base_url": "http://127.0.0.1:8090/v1/chat/completions",
      "api_key": "llama.cpp",
      "models": ["noctrex/MiniMax-M2-139B","noctrex/Qwen3-Next-80B","noctrex/Nemotron-3-Nano-30B"]
    },
    {
      "name": "openrouter",
      "api_base_url": "https://openrouter.ai/api/v1/chat/completions",
      "api_key": "${OPENROUTER_API_KEY}",
      "models": [
        "mistralai/devstral-2512:free",
        "xiaomi/mimo-v2-flash:free",
        "google/gemini-3-flash-preview",
        "google/gemini-3-pro-preview",
        "anthropic/claude-sonnet-4.5",
        "x-ai/grok-4.1-fast",
        "qwen/qwen-plus-2025-07-28",
        "qwen/qwen3-coder:exacto",
        "moonshotai/kimi-k2-0905:exacto",
        "deepseek/deepseek-v3.2-speciale",
        "perplexity/sonar",
      ],
      "transformer": {
        "use": ["openrouter"]
      }
    },
    {
      "name": "deepseek",
      "api_base_url": "https://api.deepseek.com/chat/completions",
      "api_key": "${DEEPSEEK_API_KEY}",
      "models": ["deepseek-chat", "deepseek-reasoner"],
      "transformer": {
        "use": ["deepseek"],
        "deepseek-chat": {
          "use": ["tooluse"]
        }
      }
    }
  ],
  "Router": {
    "default": "${AGENT_INFERENCE_SERVER},${AGENT_MAIN_MODEL}",
    "background": "${AGENT_INFERENCE_SERVER},${AGENT_BACKGROUND_MODEL}",
    "think": "${AGENT_INFERENCE_SERVER},${AGENT_BACKGROUND_MODEL}",
    "longContext": "${AGENT_INFERENCE_SERVER},${AGENT_BACKGROUND_MODEL}",
    "longContextThreshold": 131072,
    "webSearch": "openrouter,perplexity/sonar"
  }
}
EOT

bun install -g @qwen-code/qwen-code@latest
bun install -g @anthropic-ai/claude-code@latest
bun install -g @musistudio/claude-code-router@latest


# All MCP via NCP
sudo mkdir -p /opt/npm-global/{bin,lib/node_modules}
sudo chgrp users -R /opt/npm-global
sudo chmod -R 775 /opt/npm-global

npm config set prefix ~/.npm-global
npm install -g @portel/ncp@latest
grep -q 'npm-global' ~/.bashrc || echo 'export PATH="~/.npm-global/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
echo $PATH
# todo wait when fix https://github.com/portel-dev/ncp/issues/11
# bun install -g @portel/ncp
# npm install -g @portel/ncp@latest

echo "${GITHUB_TOKEN}" | gh auth login --with-token --git-protocol https



# ncp add -y --token=${GITHUB_TOKEN} github
ncp add -y gitmcp https://gitmcp.io/docs/
ncp add -y context7 -- npx -y @upstash/context7-mcp@latest
ncp add --env PORT="${VIBE_KANBAN_PORT:-8888}" -y vibe_kanban -- npx -y vibe-kanban@latest --mcp
ncp list 

claude mcp add --scope user ncp ncp || true
claude mcp list

qwen mcp add --scope user ncp ncp || true
qwen mcp list

# ass LSP to claude code
grep -q 'ENABLE_LSP_TOOL' ~/.bashrc || echo 'export ENABLE_LSP_TOOL=1' >> ~/.bashrc
source ~/.bashrc



uv tool install pyright@latest
go install golang.org/x/tools/gopls@latest
rustup component add rust-analyzer
sudo apt install -y clangd
bun install -g vscode-langservers-extracted

claude plugin install gopls@claude-code-lsps || true
claude plugin install vtsls@claude-code-lsps || true
claude plugin install pyright@claude-code-lsps || true
claude plugin install clangd@claude-code-lsps || true
claude plugin install rust-analyzer@claude-code-lsps || true
claude plugin install vscode-html-css@claude-code-lsps || true

ccr stop || true

screen -L -Logfile /tmp/ccr-server.log -dmS ccr-server ccr start
screen -list