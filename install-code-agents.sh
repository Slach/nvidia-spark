CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${CUR_DIR}/.env"

bash "$CUR_DIR/install-bun.sh"

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
ncp add -y duckduckgo -- npx -y duckduckgo-mcp-server@latest
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

# compact context for big outputs
claude plugin marketplace add mksglu/claude-context-mode || true
claude plugin uninstall context-mode@claude-context-mode || true

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

bunx get-shit-done-cc --all --global

claude plugin marketplace add https://github.com/Yeachan-Heo/oh-my-claudecode || true
claude plugin install oh-my-claudecode

# /tdd-guard:setup
claude plugin marketplace add nizos/tdd-guard || true
claude plugin install tdd-guard@tdd-guard


claude plugin marketplace update
claude plugin list --json | jq -r '.[].id' | xargs -I{} claude plugin update {}