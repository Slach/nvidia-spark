#!/bin/bash
# Start the docker-compose sglang service from a per-model config yaml
# (docker/sglang-configs/<name>.yaml, same convention as docker/vllm-configs/*.yaml).
# Select the model with SGLANG_CONFIG in .env or as argv[1].
#
#   ./run-sglang-docker.sh [config-name]
#
# yaml keys map 1:1 to `sglang serve` CLI flags (kebab-case); the `image` key picks the
# container image. The script exports SGLANG_MODEL / SGLANG_SERVE_ARGS / SGLANG_IMAGE for
# compose interpolation, so run-claude-code-router.sh (which reads ${SGLANG_MODEL} for the
# ccr provider list) must be re-run after switching models.
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
CONFIG="${1:-${SGLANG_CONFIG:-inkling-2-mini}}"
CONFIG_FILE="${CUR_DIR}/docker/sglang-configs/${CONFIG}.yaml"

if [[ ! -f "${CONFIG_FILE}" ]]; then
  echo "ERROR: config not found: ${CONFIG_FILE}" >&2
  echo "available:" >&2
  ls "${CUR_DIR}/docker/sglang-configs/" 2>/dev/null | sed 's/^/  /' >&2
  exit 1
fi

# yaml -> compose env: boolean true = bare flag, other values = --key value
eval "$(python3 - "${CONFIG_FILE}" <<'PY'
import sys, yaml
cfg = yaml.safe_load(open(sys.argv[1]))
image = cfg.pop("image", None)
serve = []
for k, v in cfg.items():
    flag = "--" + k
    if v is True:
        serve.append(flag)
    elif v is False or v is None:
        continue
    else:
        serve.append(f"{flag} {v}")
model = cfg.get("model-path", "")
print(f"export SGLANG_IMAGE={image!r}")
print(f"export SGLANG_MODEL={model!r}")
print(f"export SGLANG_SERVE_ARGS={\" \".join(serve)!r}")
PY
)" || exit 1

echo "sglang config : ${CONFIG}"
echo "sglang image  : ${SGLANG_IMAGE}"
echo "sglang model  : ${SGLANG_MODEL}"
echo "sglang args   : ${SGLANG_SERVE_ARGS}"
echo
cd "${CUR_DIR}"
docker compose up -d --force-recreate --wait --wait-timeout 900 sglang
docker logs nvidia-spark-sglang-1 --since 1m 2>&1 | grep -E "ready to roll|max_total_num_tokens" | tail -2
echo "gateway: http://127.0.0.1:30000 (OpenAI-compatible /v1/chat/completions, model id = the model path)"
