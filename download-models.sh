pipx upgrade-all
# CODING MODELS
## for llama.cpp GGUF

# hf download --max-workers=$(nproc) unsloth/Qwen-AgentWorld-35B-A3B-GGUF --include="*UD-Q4_K_XL*" --include="*imatrix*"
# hf cache rm -y model/unsloth/Qwen-AgentWorld-35B-A3B-GGUF
# model was removed from huggingface
# hf download --max-workers=$(nproc) protoLabsAI/ThinkingCap-Qwen3.6-27B-heretic-MTP-GGUF --include="*NVFP4*"
hf cache rm -y model/protoLabsAI/ThinkingCap-Qwen3.6-27B-heretic-MTP-GGUF

hf cache rm -y model/mudler/Ornith-1.5-35B-A3B-APEX-MTP-GGUF
ms download --max-workers=$(nproc) --model Tariel/Ornith-1.5-35B-A3B-MTP-GGUF --include "*mtp-head/*" --include "*I-Quality*" --include="*mmproj*"
hf download --max-workers=$(nproc) ornith-ai/Ornith-1.5-35B-A3B-GGUF --include "*Q4_K_M*" --include="*mmproj*"
hf download --max-workers=$(nproc) shisa-ai/Ornith-1.5-35B-A3B-MTP-ONLY

hf download --max-workers=$(nproc) unsloth/Qwen3.8-27B-GGUF --include "*UD-Q4_K_XL*" --include="*mmproj*BF16*" --include="MTP/*mtp*"
# hf download --max-workers=$(nproc) ggml-org/Qwen3.8-27B-GGUF --include "*Q4*" --include="*mmproj*Q8*"
hf cache rm -y model/ggml-org/Qwen3.8-27B-GGUF
# Signal-3.8-27B = token-efficiency fine-tune of Qwen3.8-27B (vision kept, thinking by default)
# hf download --max-workers=$(nproc) agentionai/Signal-3.8-27B-GGUF --include "*Q4_K_XL*" --include "*mmproj*"
hf cache rm -y model/agentionai/Signal-3.8-27B-GGUF
# incoai DFlash2 draft - only consumer was byteshape/Qwen3.8-27B-IQ4_XS-DFlash2 (removed)
# hf download --max-workers=$(nproc) incoai/Qwen3.8-27B-DFlash2-GGUF  --include "*Q4*"
hf cache rm -y model/incoai/Qwen3.8-27B-DFlash2-GGUF
# Altworld Hemmingway-1 = Qwen3.8-27B fine-tune, MTP embedded in every quant, text-only (no mmproj)
hf download --max-workers=$(nproc) bartowski/Altworld_Hemmingway-1-GGUF --include "*Q4_K_M*"
# HemmingwayAI Hemmingway-1.5 = Hemmingway-1 (Qwen3.8-27B) fine-tune, MTP embedded in every quant (Q4_0 draft),
# text-only (no mmproj), quants need llama.cpp b11969+
hf download --max-workers=$(nproc) bartowski/HemmingwayAI_Hemmingway-1.5-GGUF --include "*Q4_K_M*"

# ShapeLearn per-tensor hybrid quants of Qwen3.8-27B, MTP head embedded in every GGUF
# IQ4_XS-3.84bpw = GPU-5 (13.1GB), best quality of the release; mmproj-bf16 for vision
# hf download --max-workers=$(nproc) byteshape/Qwen3.8-27B-GGUF --include "*IQ4*" --include "*mmproj*"
hf cache rm -y model/byteshape/Qwen3.8-27B-GGUF
# hf download --max-workers=$(nproc) webhie/Qwen3.8-27B-Q4-AutoRound-Code-GGUF
hf cache rm -y model/webhie/Qwen3.8-27B-Q4-AutoRound-Code-GGUF

# Qwen3.8-27B-Flash (Claude Opus distill), 1M context via baked YaRN, DSpark draft model in speculative/
hf download --max-workers=$(nproc) Solstice-AI/Qwopus3.8-27B-Flash-GGUF-1M --include "*UD-Q4_K_XL*" --include "*json*" --include "*speculative*" --include="*mmproj*"
# same model, original 262k quant from the author (no YaRN), embedded MTP head
# hf download --max-workers=$(nproc) Jackrong/Qwopus3.8-27B-Flash-GGUF --include "*MTP-Q4_K_M*"
hf cache rm -y model/Jackrong/Qwopus3.8-27B-Flash-GGUF

# Recursive Flint 39.8B MoE (2.5B active), 256K ctx, Apache-2.0, strongest <50B MoE on agentic coding
# needs llama.cpp release with flint arch support, see https://unsloth.ai/docs/models/flint
hf download --max-workers=$(nproc) unsloth/flint-GGUF --include "*UD-Q4_K_XL*" --include "*imatrix*"

# Nanbeige4.3-33B dense agent/reasoning (Llama arch, ChatML, thinking on default, native 131k ctx)
# quantization-sensitive model: AD-Q4_K_M (Atomic Dynamic imatrix, top-1 92.6%) >> plain Q4_K_M (89.9%)
# card https://huggingface.co/AtomicChat/Nanbeige4.3-33B-GGUF
# hf download --max-workers=$(nproc) AtomicChat/Nanbeige4.3-33B-GGUF --include "Nanbeige4.3-33B-AD-Q4_K_M*" --include "Nanbeige4.3-33B-Q4_K_M*"
hf cache rm -y model/AtomicChat/Nanbeige4.3-33B-GGUF

# hf download --max-workers=$(nproc) unsloth/Laguna-S-2.1-GGUF --include "*UD-Q4_K_XL*"
hf cache rm -y model/unsloth/Laguna-S-2.1-GGUF
hf download --max-workers=$(nproc) unsloth/Muse-Glimmer-30B-GGUF --include "*UD-Q4_K_XL*" --include "*kquant*"
hf download --max-workers=$(nproc) unsloth/NVIDIA-Nemotron-3.5-Lightning-30B-A3B-GGUF --include "*UD-Q4_K_XL*"

# Sakura = abliterated edit (refusal direction removed, 128 language tensors) of NVIDIA-Nemotron-3.5-Bolt-74B-A9B-24GB,
# nemotron_h_moe Mamba-hybrid MoE, mixed IQ2_XXS/NVFP4/Q8_0 expert quants + Q8_0-edited 128 tensors,
# Q8_0-edited closer to NVIDIA original than F16-edited (KLD 0.019 vs 0.154), text-only, no MTP, needs llama.cpp b11681+
# card https://huggingface.co/webmp3/Sakura-Nemotron-3.5-Bolt-74B-A9B-24GB-Uncensored-GGUF
hf download --max-workers=$(nproc) webmp3/Sakura-Nemotron-3.5-Bolt-74B-A9B-24GB-Uncensored-GGUF --include "*Q8_0*"

# DavidAU Qwen3-48B-A4B-Savant-Commander-Distill-12X (Qwen3 MoE 48B, 12X expert-expanded
# distill + Closed-Open-Heretic uncensoring), Q4_K_M 20.4GB, no MTP head -> plain decode
# MANDATORY llama.cpp override (model card is WRONG, see discussion
# https://huggingface.co/DavidAU/Qwen3-48B-A4B-Savant-Commander-Distill-12X-Closed-Open-Heretic-Uncensored-GGUF/discussions/2):
#   --override-kv qwen3moe.expert_used_count=int:6
hf download --max-workers=$(nproc) DavidAU/Qwen3-48B-A4B-Savant-Commander-Distill-12X-Closed-Open-Heretic-Uncensored-GGUF --include "*Q4_K_M*"

# 403 suki pidarasi ;)
# hf download --max-workers=$(nproc) meta-models/Muse-Glimmer-30B-GGUF --include="*dynamic*" --include="*kquant*"
hf cache rm -y model/meta-models/Muse-Glimmer-30B-GGUF
# phucngodev/Qwen3.5-9B-MTP - never had a download line here, cache leftover
hf cache rm -y model/phucngodev/Qwen3.5-9B-MTP


# wait when resolve https://github.com/ggml-org/llama.cpp/pull/26608
# hf download --max-workers=$(nproc) AtomicChat/Ling-3.0-flash-NVFP4-GGUF --include "*AD-NVFP4*"

# need fork llama.cpp
# Bonsai 1 27B, still in cache (17.8G)
# hf download --max-workers=$(nproc) prism-ml/Ternary-Bonsai-27B-gguf --include="*Q8*" --include="*Q4*" --include="*Q2_0*" --include="*BF16*"

# Bonsai 2 27B ternary g128 (98.2% of FP16 avg at 1.72 bpw), needs PrismML-Eng/llama.cpp fork (service bonsai, image llama.cpp:prism-full)
# PQ2_0 = 2-bit slots 7.21GB (Blackwell pick), PTQ1_0 = dense trits 5.95GB; stock llama.cpp rejects both (ggml types 142/143)
# no plain Q2_0 in this repo - stock loads Q2_0 silently producing garbage without Hadamard activation runtime
hf download --max-workers=$(nproc) prism-ml/Ternary-Bonsai-2-27B-gguf --include="*PQ2_0*" --include="*mmproj-Q8_0*"
# Bonsai 1 not used anymore (superseded by Bonsai 2)
hf cache rm -y model/prism-ml/Ternary-Bonsai-27B-gguf

# qwen3.5 for programming
hf download --max-workers=$(nproc) deepreinforce-ai/Ornith-1.0-35B-GGUF --include="*Q8*" --include="*Q4*"
hf download --max-workers=$(nproc) a4lg/Qwen3.5-35B-A3B-MTP-ONLY-GGUF --include="*BF16*"
hf download --max-workers=$(nproc) juan1995-dev/Qwen3.5-35B-A3B-mmproj-BF16-GGUF
hf download --max-workers=$(nproc) froggeric/Qwen-Fixed-Chat-Templates

hf download --max-workers=$(nproc) unsloth/gemma-4-31B-it-qat-GGUF
hf download --max-workers=$(nproc) unsloth/gemma-4-12B-it-qat-GGUF
hf download --max-workers=$(nproc) unsloth/gemma-4-26B-A4B-it-qat-GGUF
hf download --max-workers=$(nproc) yuxinlu1/gemma-4-12B-coder-fable5-composer2.5-v1-GGUF --include="*Q8*"
hf download --max-workers=$(nproc) mradermacher/Gemma-4-Novelist-31B-i1-GGUF --include="*Q4_K_M*"
hf download --max-workers=$(nproc) unsloth/Qwen3.6-27B-MTP-GGUF  --include="*UD-Q4_K_XL*" --include="*mmproj*"
hf download --max-workers=$(nproc) unsloth/Qwen3.6-35B-A3B-MTP-GGUF --include="*UD-Q4_K_XL*" --include="*mmproj*"
# empero-ai/Qwen3.8-35B-A3B-Distill = Qwen3.8 frontier distill into Qwen3.6-35B-A3B MoE arch
# (30 Gated DeltaNet + 10 full-attn layers, 256 experts top-8), reasoning model, vision inherited from Qwen3.6 base
# block_count=41 = 40 trunk + 1 full MTP block (blk.40 own attn+MoE + nextn.* tensors) -> embedded draft-mtp works,
# same tensor layout as unsloth/Qwen3.6-35B-A3B-MTP-GGUF, no external draft needed
hf download --max-workers=$(nproc) empero-ai/Qwen3.8-35B-A3B-Distill-GGUF --include="*Q4_K_M*" --include="*mmproj*"
# hf download --max-workers=$(nproc) empero-ai/Qwythos-9B-Claude-Mythos-5-1M-GGUF --include="*MTP*Q8*" --include="*mmproj*"
hf cache rm -y model/empero-ai/Qwythos-9B-Claude-Mythos-5-1M-GGUF

hf cache rm -y model/MaralGPT/MaralGPT-Mythos-9B-2606-GGUF
hf cache rm -y model/Guilherme34/Firefly-v4-BetterGGUF
hf cache rm -y model/llmfan46/Qwen3.5-35B-A3B-uncensored-heretic-v2-Native-MTP-Preserved-NVFP4-GGUF
hf cache rm -y model/catlilface/Gemma-4-26B-A4B-NVFP4-GGUF

# medicine
# not used in any serving config, cache cleaned 2026-11-09
# hf download --max-workers=$(nproc) mradermacher/AntAngelMed-i1-GGUF --include="*Q4_K_M*" --include="*imatrix*"
hf cache rm -y model/mradermacher/AntAngelMed-i1-GGUF

# hf download --max-workers=$(nproc) CISCai/gemma-4-31B-it-NVFP4-turbo-GGUF
hf cache rm -y model/CISCai/gemma-4-31B-it-NVFP4-turbo-GGUF
# hf download --max-workers=$(nproc) mudler/Qwen3.6-35B-A3B-APEX-GGUF --include="*mmproj*" --include="*I-Quality*" --include="*I-Mini*"
hf cache rm -y model/mudler/Qwen3.6-35B-A3B-APEX-GGUF

hf cache rm -y model/noctrex/Qwen3.6-35B-A3B-MXFP4_MOE-GGUF
hf cache rm -y model/noctrex/Qwen3.5-35B-A3B-MXFP4_MOE-GGUF

hf cache rm -y model/noctrex/Qwen3.5-35B-A3B-Claude-4.6-Opus-Reasoning-Distilled-MXFP4_MOE-GGUF
hf cache rm -y model/noctrex/LFM2-24B-A2B-MXFP4_MOE-GGUF


hf cache rm -y model/unsloth/Qwen3.6-35B-A3B-GGUF
hf cache rm -y model/unsloth/Qwen3.6-27B-GGUF

hf cache rm -y model/unsloth/Qwen3.5-35B-A3B-GGUF
hf cache rm -y model/unsloth/Qwen3.5-27B-GGUF


hf cache rm -y model/danielcherubini/Qwen3.5-DeltaCoder-9B-GGUF
hf cache rm -y model/mradermacher/Nemotron-Cascade-2-30B-A3B-i1-GGUF
hf cache rm -y model/Exil01/Qwen3.5-35B-Uncensored-YaRN-1M
hf cache rm -y model/Ex0bit/Qwen3.5-122B-A10B-PRISM-LITE-GGUF
hf cache rm -y model/unsloth/gemma-4-31B-it-GGUF
hf cache rm -y model/OpenMOSE/Qwen3.5-REAP-97B-A10B-GGUF
hf cache rm -y model/Exil01/Qwen3.5-27B-Opus-v2-YaRN-1M
hf cache rm -y model/Biomanticus/RYS-Qwen3.5-27B-gguf
hf cache rm -y model/unsloth/Qwen3.5-122B-A10B-GGUF
hf cache rm -y model/Qwen/Qwen3-Coder-Next-GGUF

# hf download --max-workers=$(nproc) mradermacher/Strand-Rust-Coder-14B-v1-GGUF --include "*Q8_0*"
hf cache rm -y model/mradermacher/Strand-Rust-Coder-14B-v1-GGUF

hf cache rm -y model/dinerburger/Qwen3.5-27B-GGUF
hf cache rm -y model/lmstudio-community/Qwen3.5-27B-GGUF

hf cache rm -y model/unsloth/GLM-4.7-Flash-GGUF
hf cache rm -y model/DavidAU/GLM-4.7-Flash-Uncensored-Heretic-NEO-CODE-Imatrix-MAX-GGUF
hf cache rm -y model/cturan/IQuest-Coder-V1-40B-Instruct-GGUF


hf cache rm -y model/noctrex/MiniMax-M2-REAP-139B-A10B-MXFP4_MOE-GGUF
hf cache rm -y model/rushyrush/MiniMax-M2.1-REAP-139B-A10B-GGUF

hf cache rm -y model/noctrex/Qwen3-Next-80B-A3B-Instruct-1M-MXFP4_MOE-GGUF


hf cache rm -y model/noctrex/GLM-4.6V-MXFP4_MOE-GGUF
hf cache rm -y model/unsloth/Devstral-2-123B-Instruct-2512-GGUF

hf cache rm -y model/mradermacher/GLM-4.6-REAP-218B-A32B-Derestricted-i1-GGUF

hf cache rm -y model/bartowski/zai-org_GLM-4.7-GGUF
hf cache rm -y model/AaryanK/MiniMax-M2.1-GGUF

# just for fun, Russian Chat models
# hf download --max-workers=$(nproc) ai-sage/GigaChat3.1-10B-A1.8B-GGUF --include="*q8*"
hf cache rm -y model/ai-sage/GigaChat3.1-10B-A1.8B-GGUF
# hf download --max-workers=$(nproc) t-tech/T-pro-it-2.1-GGUF --include="*Q4_K_M*"
hf cache rm -y model/t-tech/T-pro-it-2.1-GGUF

## for vllm & sglang safetensors
# chisel-nvfp4-dflash2-replay recipe (https://github.com/yuanlin2004/chisel-spark-recipes),
# 65.1 t/s decode on DGX Spark: unsloth NVFP4 target 13GB + Chisel DFlash2 NVFP4 drafter 1.3GB
# vllm:chisel image + docker/vllm-configs/qwen3.8-27b-chisel-nvfp4.yaml
hf download --max-workers=$(nproc) unsloth/Qwen3.8-27B-NVFP4
hf download --max-workers=$(nproc) yuanlin2004/Qwen3.8-27B-Chisel-DFlash2-NVFP4-drafter
# Recursive Flint for vLLM (vllm/vllm-openai:flint-arm64-cu130 image, vllm PR #62938):
# NVFP4 GGUF 23GB runs W4A16 via Marlin on GB10/sm_120 (custom SM100 kernels don't apply),
# config+tokenizer come from the BF16 repo (--hf-config-path/--tokenizer RecursiveSI/flint)
hf download --max-workers=$(nproc) RecursiveSI/flint-nvfp4-gguf
hf download --max-workers=$(nproc) RecursiveSI/flint --include "*.json" --include "*.jinja" --include "sglang/*"
# https://github.com/MiaAI-Lab/Qwen3.8-Flash-Next-Single-DGX-Spark single DGX Spark recipe
# needs patches from MiaAI-Lab repo + packed PLE table (~27GB extra, built on first launch)
# hf download --max-workers=$(nproc) Mia-AiLab/Qwen3.8-Flash-Next-NVFP4
hf cache rm -y model/Mia-AiLab/Qwen3.8-Flash-Next-NVFP4
hf download --max-workers=$(nproc) AEON-7/Qwen3.6-27B-AEON-Ultimate-Uncensored-Multimodal-NVFP4-MTP-XS
hf download --max-workers=$(nproc) z-lab/Qwen3.6-27B-DFlash
# hf download --max-workers=$(nproc) AEON-7/Qwen3.6-35B-A3B-heretic-NVFP4
hf cache rm -y model/AEON-7/Qwen3.6-35B-A3B-heretic-NVFP4
hf download --max-workers=$(nproc) z-lab/Qwen3.6-35B-A3B-DFlash
hf cache rm -y model/nvidia/NVIDIA-Nemotron-Labs-3-Puzzle-75B-A9B-NVFP4

# Ricursive Ripple-65B-Preview (dense 65B, 80 layers = 4 SWA-1024 + 1 NoPE full-attn per 5,
# native 2M ctx), TerminalBench 2.1 = 80.52 - strongest <100B agentic coder
# NVFP4 checkpoint 57.2GB (ModelOpt: NVFP4 MLP + BF16 attention/KV, no fp8 KV allowed)
# + BF16 DFlash2 drafter 4GB (acceptance 7.34 mean @15 draft tokens, GSM8K)
# native vLLM support via vllm PR #65745 (merged 2026-11-05, needs vllm >= 0.33.0 nightly;
# no trust-remote-code - RicursiveConfig is built-in), official recipe recipes/models/ricursiveAI/
# config docker/vllm-configs/ripple-65b-preview-nvfp4.yaml
hf download --max-workers=$(nproc) ricursiveAI/Ripple-65B-Preview-NVFP4
hf download --max-workers=$(nproc) ricursiveAI/Ripple-65B-Preview-DFlash2

# todo 1M context - doesn't work (stuck/OOMKilled per .env), cache cleaned 2026-11-09
# hf download --max-workers=$(nproc) poolside/Laguna-S-2.1-NVFP4
# hf download --max-workers=$(nproc) poolside/Laguna-S-2.1-DFlash-NVFP4
hf cache rm -y model/poolside/Laguna-S-2.1-NVFP4
hf cache rm -y model/poolside/Laguna-S-2.1-DFlash-NVFP4
# 256k context
hf download --max-workers=$(nproc) nvidia/NVIDIA-Nemotron-3.5-Lightning-30B-A3B-NVFP4
hf download --max-workers=$(nproc) nvidia/NVIDIA-Nemotron-3.5-Lightning-30B-A3B-NVFP4-DSpark
# 1-3 t/s generation, why so slow? - dead experiment, cache cleaned 2026-11-09
# hf download --max-workers=$(nproc) nvidia/Gemma-4-31B-IT-NVFP4
hf cache rm -y model/nvidia/Gemma-4-31B-IT-NVFP4

# 131k context
# hf download --max-workers=$(nproc) Inferact/Muse-Glimmer-30B-NVFP4-W4A4
hf cache rm -y model/Inferact/Muse-Glimmer-30B-NVFP4-W4A4


# https://github.com/Avarok-Cybersecurity/atlas/issues/106
hf download --max-workers=$(nproc) Qwen/Qwen3.6-35B-A3B-FP8
# https://github.com/Avarok-Cybersecurity/atlas/issues/106
hf download --max-workers=$(nproc) RedHatAI/Qwen3.6-35B-A3B-NVFP4 --exclude="*score*" --exclude="*eval_ever*"
# https://github.com/Avarok-Cybersecurity/atlas/issues/107
hf download --max-workers=$(nproc) nvidia/Qwen3.6-35B-A3B-NVFP4
hf cache rm -y model/Qwen/Qwen3.5-35B-A3B-FP8
hf cache rm -y model/Qwen/Qwen3.5-27B-FP8
# hf download --max-workers=$(nproc) selimaktas/Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled-v2-NVFP4A16


# hf download --max-workers=$(nproc) LilaRest/gemma-4-31B-it-NVFP4-turbo
hf cache rm -y model/LilaRest/gemma-4-31B-it-NVFP4-turbo
hf cache rm -y model/sakamakismile/Huihui-Qwen3.6-27B-abliterated-NVFP4-MTP

# hf download --max-workers=$(nproc) AxionML/Qwen3.5-35B-A3B-NVFP4
hf cache rm -y model/AxionML/Qwen3.5-35B-A3B-NVFP4
hf cache rm -y model/ig1/Qwen3-Next-80B-A3B-Instruct-NVFP4

# hf download --max-workers=$(nproc) cyankiwi/GLM-4.7-Flash-AWQ-8bit
hf cache rm -y model/cyankiwi/GLM-4.7-Flash-AWQ-8bit
# vLLM only - require polarquant
hf download --max-workers=$(nproc) caiovicentino1/Qwopus3.5-27B-v3-PolarQuant-Q5
# vLLM only - require paroquant
hf download --max-workers=$(nproc) z-lab/gemma-4-31B-it-PARO

# hf download --max-workers=$(nproc) unsloth/Qwen3-Next-80B-A3B-Instruct-bnb-4bit
hf cache rm -y model/unsloth/Qwen3-Next-80B-A3B-Instruct-bnb-4bit
# hf download --max-workers=$(nproc) nvidia/NVIDIA-Nemotron-3-Nano-30B-A3B-FP8
hf cache rm -y model/nvidia/NVIDIA-Nemotron-3-Nano-30B-A3B-FP8
# rnj-1 not used anywhere (noctrex rnj GGUF already removed), cache cleaned 2026-11-09
# hf download --max-workers=$(nproc) EssentialAI/rnj-1-instruct
hf cache rm -y model/EssentialAI/rnj-1-instruct

# hf download --max-workers=$(nproc) ArliAI/GLM-4.5-Air-Derestricted-GPTQ-Int4-Int8-Mixed
hf cache rm -y model/ArliAI/GLM-4.5-Air-Derestricted-GPTQ-Int4-Int8-Mixed

# hf download --max-workers=$(nproc) Qwen/Qwen3-Coder-30B-A3B-Instruct-FP8
hf cache rm -y model/Qwen/Qwen3-Coder-30B-A3B-Instruct-FP8

## single GGUF can be used with vLLM + llama.cpp

# hf download --max-workers=$(nproc) noctrex/Nemotron-3-Nano-30B-A3B-MXFP4_MOE-GGUF
hf cache rm -y model/noctrex/Nemotron-3-Nano-30B-A3B-MXFP4_MOE-GGUF

# hf download --max-workers=$(nproc) noctrex/MiroThinker-v1.5-30B-MXFP4_MOE-GGUF
hf cache rm -y model/noctrex/MiroThinker-v1.5-30B-MXFP4_MOE-GGUF

# hf download --max-workers=$(nproc) noctrex/HyperNova-60B-MXFP4_MOE-GGUF
hf cache rm -y model/noctrex/HyperNova-60B-MXFP4_MOE-GGUF

# hf download --max-workers=$(nproc) juanml82/Huihui-Qwen3-Next-80B-A3B-Thinking-abliterated-gguf
hf cache rm -y model/juanml82/Huihui-Qwen3-Next-80B-A3B-Thinking-abliterated-gguf

# hf download --max-workers=$(nproc) bartowski/Nanbeige_Nanbeige4-3B-Thinking-2511-GGUF --include "*Q8_0*"
hf cache rm -y model/bartowski/Nanbeige_Nanbeige4-3B-Thinking-2511-GGUF

## embedding models
hf download --max-workers=$(nproc) endyjasmi/Qwen3-Embedding-8B-Q4_K_M-GGUF
hf download --max-workers=$(nproc) aiteza/Qwen3-VL-Embedding-8B-GGUF
hf download --max-workers=$(nproc) sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2

# decision system1 models
# native decision models (embedding-model wrappers with decision head) from llama.cpp PR #29818
# https://github.com/ggml-org/llama.cpp/pull/29818 (merged 2026-10-02), served via POST /v1/systemone
# classification only - NO text generation; three question types: choice / score / noul
# needs llama.cpp with server-decision.cpp (image llama.cpp:spark-full rebuilt from b12360 2026-11-13)
# laya = convaiinnovations/laya (BERT-like), 0.42GB Q8_0, up to 255 choice options,
#   whole prompt evaluated in ONE ubatch -> ubatch-size must cover the full prompt
hf download --max-workers=$(nproc) ggml-org/Laya-GGUF --include "*Q8_0*"
# julia-1 = SupersonicLabs/Julia-1, smallest one, 0.16GB Q8_0
# DOESN'T LOAD in stock llama.cpp (checked b12202/b12360): "metaspace prepend_scheme 'always'
# is not supported for BPE vocab" - kept in cache, ini section commented until upstream fix
hf download --max-workers=$(nproc) ggml-org/Julia-1-GGUF --include "*Q8_0*"
# lev = interfaze-ai/lev (Qwen3.5-4B base), zero-shot classification, 4.17GB Q8_0
hf download --max-workers=$(nproc) ggml-org/lev-GGUF --include "*Q8_0*"
# openjev = openjev/openjev, MULTIMODAL decision model (vision via mmproj, CC BY-NC 4.0 - non-commercial),
#   26.6GB Q8_0 + mmproj 0.59GB, up to 52 choice options
hf download --max-workers=$(nproc) ggml-org/OpenJev-GGUF --include "*Q8_0*"
# kev-4b = jaredpalmer/kev-4b (Qwen3.5-4B-Base), text classification, 4.18GB Q8_0
hf download --max-workers=$(nproc) ggml-org/Kev-4B-GGUF --include "*Q8_0*"

## image models ComfyUI
# hf download --max-workers=$(nproc) Comfy-Org/Qwen-Image-Edit_ComfyUI --include "*2511_fp8*" --include "*loras*"
# hf download --max-workers=$(nproc) Comfy-Org/Qwen-Image-Layered_ComfyUI
hf cache rm -y model/Comfy-Org/Qwen-Image-Layered_ComfyUI
# hf download --max-workers=$(nproc) Comfy-Org/flux2-dev --exclude "*bf16*"
# hf download --max-workers=$(nproc) lightx2v/Qwen-Image-Edit-2511-Lightning --exclude "*bf16*"
# hf download --max-workers=$(nproc) unsloth/Qwen-Image-Edit-2511-GGUF --include="*Q4_K_M*"

## video+image models ComfyUI + diffusers custom nodes
# hf download --max-workers=$(nproc) kandinskylab/Kandinsky-5.0-I2V-Pro-distilled-5s-Diffusers
# hf download --max-workers=$(nproc) kandinskylab/Kandinsky-5.0-T2V-Pro-distilled-5s-Diffusers
# hf download --max-workers=$(nproc) kandinskylab/Kandinsky-5.0-I2I-Lite-sft-Diffusers
# hf download --max-workers=$(nproc) kandinskylab/Kandinsky-5.0-T2I-Lite-sft-Diffusers

# animation + video
# hf download --max-workers=$(nproc) Wan-AI/Wan2.2-Animate-14B
hf cache rm -y model/Wan-AI/Wan2.2-Animate-14B
# hf download --max-workers=$(nproc) lightx2v/Wan2.2-Lightning

# ComfyUI media models cleanup 2026-11-09 (not used, ~495GB freed):
hf cache rm -y model/kandinskylab/Kandinsky-5.0-T2V-Pro-distilled-5s-Diffusers
hf cache rm -y model/kandinskylab/Kandinsky-5.0-I2V-Pro-distilled-5s-Diffusers
hf cache rm -y model/kandinskylab/Kandinsky-5.0-T2I-Lite-sft-Diffusers
hf cache rm -y model/kandinskylab/Kandinsky-5.0-I2I-Lite-sft-Diffusers
hf cache rm -y model/microsoft/TRELLIS.2-4B
hf cache rm -y model/inclusionAI/LLaDA-Image-Turbo
hf cache rm -y model/h94/IP-Adapter
hf cache rm -y model/ResembleAI/chatterbox
hf cache rm -y model/ResembleAI/chatterbox-turbo
# LLM leftovers: no active download line / ini section, vllm profile dead (sglang issue #20973)
hf cache rm -y model/Qwen/Qwen3-Next-80B-A3B-Instruct-GGUF
hf cache rm -y model/Kbenkhaled/Qwen3.5-35B-A3B-NVFP4

# guard models to avoid inference attacks
hf download --max-workers=$(nproc) geoffmunn/Qwen3Guard-Stream-8B --include="*Q4_K_M*"

#VLM
# long horizon text
# (typo fix 2026-11-09: repo id was missing the noctrex/ prefix, rm never fired)
hf cache rm -y model/noctrex/Jan-v2-VL-max-MXFP4_MOE-GGUF
hf cache rm -y model/noctrex/Qwen3-VL-30B-A3B-Thinking-1M-MXFP4_MOE-GGUF

# Voice
hf download --max-workers=$(nproc) onnx-community/chatterbox-multilingual-ONNX

# OCR
# hf download --max-workers=$(nproc) deepseek-ai/DeepSeek-OCR
hf cache rm -y model/deepseek-ai/DeepSeek-OCR
hf download --max-workers=$(nproc) deepseek-ai/DeepSeek-OCR-2
hf download --max-workers=$(nproc) PaddlePaddle/PaddleOCR-VL-1.5

# small interesting LLMs
hf cache rm -y model/LiquidAI/LFM2-2.6B-Exp-GGUF
# (typo fix 2026-11-09: missing trailing F, rm never fired)
hf cache rm -y model/noctrex/rnj-1-instruct-GGUF
hf cache rm -y model/tiiuae/Falcon-H1R-7B-GGUF


# to have the same /models in all configs outside docker and inside docker
sudo mkdir -p /models
sudo ln -sfn ${HOME}/.cache/huggingface /models/huggingface
sudo chown -R ${USER}:${USER} /models

hf cache prune
hf cache ls
