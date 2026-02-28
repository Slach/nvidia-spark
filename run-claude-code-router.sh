#!/bin/bash
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${CUR_DIR}/.env"

bash "$CUR_DIR/install-bun.sh"
if [[ "max-inference" == "${AGENT_INFERENCE_SERVER}" ]]; then
  mkdir -p ~/.cache/max_cache
fi

if [[ "openrouter" != "${AGENT_INFERENCE_SERVER}" ]]; then
  docker compose -f "$CUR_DIR/docker-compose.yaml" up --force-recreate -d ${AGENT_INFERENCE_SERVER}
fi 

mkdir -p ~/.claude-code-router
cat <<EOT > ~/.claude-code-router/config.json
{
  "LOG": true,
  "LOG_LEVEL": "error",
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
      "models": [
        "unsloth/Qwen3.5-120B",
        "unsloth/Qwen3.5-27B",
        "unsloth/GLM-4.7-Flash-30B",
        "Qwen/Qwen3-Coder-Next-80B-Q8",
        "noctrex/MiniMax-M2.5-139B",
        "noctrex/Qwen3-Next-80B"
      ]
    },
    {
      "name":"z.ai",
      "api_base_url": "https://api.z.ai/api/paas/v4/completions",
      "api_key": "${ZAI_API_KEY}",
      "models": [
          "glm-4.7", 
          "glm-4.7-flash", 
          "glm-4.7-flashx"
      ]
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
bun install -g opencode-ai@latest
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


sudo apt install -y clangd llvm make cmake ninja-build rustup

uv tool install pyright@latest
go install golang.org/x/tools/gopls@latest
rustup component add rust-analyzer
sudo apt install -y clangd
bun install -g vscode-langservers-extracted
bun install -g typescript-language-server typescript

# official LSP & plugins
claude plugin marketplace add anthropics/claude-plugins-official || true
claude plugin install clangd-lsp@claude-plugins-official || true
claude plugin install gopls-lsp@claude-plugins-official || true
claude plugin install php-lsp@claude-plugins-official || true
claude plugin install pyright-lsp@claude-plugins-official || true
claude plugin install typescript-lsp@claude-plugins-official || true
claude plugin install rust-analyzer-lsp@claude-plugins-official || true
# code simplifier
claude plugin install code-simplifier@claude-plugins-official || true

# HTML & CSS LSP
claude plugin marketplace add Piebald-AI/claude-code-lsps || true
claude plugin install vscode-langservers@claude-code-lsps || true

# TODO 1C - https://github.com/Piebald-AI/claude-code-lsps/tree/main/bsl-lsp

# other marketplaces
claude plugin marketplace add wshobson/agents || true
claude plugin marketplace add obra/superpowers-marketplace || true
claude plugin marketplace add K-Dense-AI/claude-scientific-skills || true
claude plugin marketplace add EveryInc/every-marketplace || true
claude plugin marketplace add sawyerhood/dev-browser || true
claude plugin marketplace add zscole/adversarial-spec || true
uv tool install superclaude
superclaude install

ccr stop || true

screen -L -Logfile /tmp/ccr-server.log -dmS ccr-server ccr start
screen -list