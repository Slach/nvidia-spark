#!/bin/bash

CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

cd "$CUR_DIR"

source "${CUR_DIR}/.env"

if [[ "llama.cpp" == "${AGENT_INFERENCE_SERVER}" ]]; then
  export ANTHROPIC_BASE_URL=http://127.0.0.1:8090/
elif [[ "sglang" == "${AGENT_INFERENCE_SERVER}" ]]; then
  export ANTHROPIC_BASE_URL=http://127.0.0.1:30000/
elif [[ "vllm" == "${AGENT_INFERENCE_SERVER}" ]]; then
  export ANTHROPIC_BASE_URL=http://127.0.0.1:30001/
elif [[ "paroquant" == "${AGENT_INFERENCE_SERVER}" ]]; then
  export ANTHROPIC_BASE_URL=http://127.0.0.1:30002/
fi

export ANTHROPIC_MODEL="${AGENT_MAIN_MODEL}" 
export ANTHROPIC_API_KEY=dummy 

claude -p "shortly describe current project" --output-format json | jq '{
  output_tokens: .usage.output_tokens,
  input_tokens: .usage.input_tokens,
  cache_read: .usage.cache_read_input_tokens,
  duration_s: (.duration_ms/1000),
  api_duration_s: (.duration_api_ms/1000),
  output_tps: (.usage.output_tokens / (.duration_api_ms/1000)),
  wallclock_tps: (.usage.output_tokens / (.duration_ms/1000)),
  cost_usd: .total_cost_usd
}'

cd -
