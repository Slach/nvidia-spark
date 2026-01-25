#!/bin/bash
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$CUR_DIR/.env"
bash "$CUR_DIR/run-claude-code-router.sh"
cat <<EOT > ~/.local/share/vibe-kanban/profiles.json
{
  "executors": {
    "CLAUDE_CODE": {
      "DEFAULT": {
        "CLAUDE_CODE": {
          "append_prompt": null,
          "claude_code_router": true,
          "plan": false,
          "approvals": false,
          "dangerously_skip_permissions": true,
          "disable_api_key": true,
          "base_command_override": "bunx --bun @musistudio/claude-code-router@latest code"
        }
      },
      "PLAN": {
        "CLAUDE_CODE": {
          "append_prompt": null,
          "claude_code_router": true,
          "plan": true,
          "approvals": false,
          "dangerously_skip_permissions": true,
          "disable_api_key": true,
          "base_command_override": "bunx --bun @musistudio/claude-code-router@latest code"
        }
      }
    },
    "QWEN_CODE": {
      "DEFAULT": {
        "QWEN_CODE": {
          "append_prompt": null,
          "yolo": true,
          "base_command_override": "bunx --bun @qwen-code/qwen-code@latest"
        }
      }
    },
    "OPENCODE": {
      "Z.AI": {
        "OPENCODE": {
         "base_command_override":"bunx --bun opencode-ai@latest"
        } 
      }
    }
  }
}
EOT

cat <<EOT > ~/.local/share/vibe-kanban/config.json
{
  "config_version": "v8",
  "theme": "DARK",
  "executor_profile": {
    "executor": "CLAUDE_CODE"
  },
  "disclaimer_acknowledged": true,
  "onboarding_acknowledged": true,
  "notifications": {
    "sound_enabled": true,
    "push_enabled": true,
    "sound_file": "COW_MOOING"
  },
  "editor": {
    "editor_type": "VS_CODE",
    "custom_command": null,
    "remote_ssh_host": null,
    "remote_ssh_user": null
  },
  "github": {
    "pat": null,
    "oauth_token": null,
    "username": "${GITHUB_USER}",
    "primary_email": "${GITHUB_EMAIL}",
    "default_pr_base": "main"
  },
  "analytics_enabled": false,
  "workspace_dir": null,
  "last_app_version": "0.0.137",
  "show_release_notes": false,
  "language": "BROWSER",
  "git_branch_prefix": "vk",
  "showcases": {
    "seen_features": [
      "task-panel-onboarding"
    ]
  },
  "pr_auto_description_enabled": true,
  "pr_auto_description_prompt": null
}
EOT

if screen -list | grep -q "vibe-kanban"; then
  screen -S vibe-kanban -X quit
fi

screen -L -Logfile /tmp/vibe-kanban.log -dmS vibe-kanban bash -c "PORT=8888 bunx vibe-kanban@latest"
screen -list
