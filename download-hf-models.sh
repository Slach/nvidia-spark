pipx upgrade-all
# CODING MODELS
## for llama.cpp GGUF

hf download --max-workers=$(nproc) noctrex/Qwen3.5-35B-A3B-MXFP4_MOE-GGUF
hf download --max-workers=$(nproc) noctrex/Qwen3.5-35B-A3B-Claude-4.6-Opus-Reasoning-Distilled-MXFP4_MOE-GGUF
hf download --max-workers=$(nproc) noctrex/LFM2-24B-A2B-MXFP4_MOE-GGUF
hf download --max-workers=$(nproc) unsloth/Qwen3.5-35B-A3B-GGUF --include="*UD-Q4_K_XL*"
hf download --max-workers=$(nproc) unsloth/Qwen3.5-27B-GGUF --include="*UD-Q4_K_XL*"
hf download --max-workers=$(nproc) mradermacher/Nemotron-Cascade-2-30B-A3B-i1-GGUF --include="*Q4_K_M*"
hf download --max-workers=$(nproc) Exil01/Qwen3.5-35B-Uncensored-YaRN-1M --include="*Q4_K_M*" --include="*f16*"
hf download --max-workers=$(nproc) Ex0bit/Qwen3.5-122B-A10B-PRISM-LITE-GGUF
hf download --max-workers=$(nproc) unsloth/gemma-4-31B-it-GGUF --include="*UD-Q4_K_XL*" --include="mmproj-BF16*"
hf download --max-workers=$(nproc) OpenMOSE/Qwen3.5-REAP-97B-A10B-GGUF --include="*Q4_K_M*" --include="*mmproj-BF16*"

# hf download --max-workers=$(nproc) Ex0bit/Qwen3.5-122B-A10B-PRISM-PRO-GGUF

# hf download --max-workers=$(nproc) Exil01/Qwen3.5-27B-Opus-v2-YaRN-1M --exclude="*BF16*"
hf cache rm -y model/Exil01/Qwen3.5-27B-Opus-v2-YaRN-1M

# hf download --max-workers=$(nproc) Biomanticus/RYS-Qwen3.5-27B-gguf --include="*Q4_K_M*"
hf cache rm -y model/Biomanticus/RYS-Qwen3.5-27B-gguf

# hf download --max-workers=$(nproc) unsloth/Qwen3.5-122B-A10B-GGUF --include="*MXFP4*"
hf cache rm -y model/unsloth/Qwen3.5-122B-A10B-GGUF


# hf download --max-workers=$(nproc) Qwen/Qwen3-Coder-Next-GGUF --include "*Q8_0*"
# hf download --max-workers=$(nproc) Qwen/Qwen3-Coder-Next-GGUF --include "*Q4_K_M*"
hf cache rm -y model/Qwen/Qwen3-Coder-Next-GGUF

hf download --max-workers=$(nproc) mradermacher/Strand-Rust-Coder-14B-v1-GGUF --include "*Q8_0*"

# hf download --max-workers=$(nproc) dinerburger/Qwen3.5-27B-GGUF
hf cache rm -y model/dinerburger/Qwen3.5-27B-GGUF
# hf download --max-workers=$(nproc) lmstudio-community/Qwen3.5-27B-GGUF --include "*Q6_K*"
hf cache rm -y model/lmstudio-community/Qwen3.5-27B-GGUF

# hf download --max-workers=$(nproc) unsloth/GLM-4.7-Flash-GGUF --include "*Q8_0*"
# hf cache rm -y model/unsloth/GLM-4.7-Flash-GGUF
hf download --max-workers=$(nproc) DavidAU/GLM-4.7-Flash-Uncensored-Heretic-NEO-CODE-Imatrix-MAX-GGUF --include="*Q8_0*"
# hf download --max-workers=$(nproc) cturan/IQuest-Coder-V1-40B-Instruct-GGUF --include "*Q4_K_M*"
hf cache rm -y model/cturan/IQuest-Coder-V1-40B-Instruct-GGUF


# hf download --max-workers=$(nproc) noctrex/MiniMax-M2-REAP-139B-A10B-MXFP4_MOE-GGUF
hf cache rm -y model/noctrex/MiniMax-M2-REAP-139B-A10B-MXFP4_MOE-GGUF
# hf download --max-workers=$(nproc) rushyrush/MiniMax-M2.1-REAP-139B-A10B-GGUF
hf cache rm -y model/rushyrush/MiniMax-M2.1-REAP-139B-A10B-GGUF

hf download --max-workers=$(nproc) noctrex/Qwen3-Next-80B-A3B-Instruct-1M-MXFP4_MOE-GGUF


# hf download --max-workers=$(nproc) noctrex/GLM-4.6V-MXFP4_MOE-GGUF
hf cache rm -y model/noctrex/GLM-4.6V-MXFP4_MOE-GGUF
# hf download --max-workers=$(nproc) unsloth/Devstral-2-123B-Instruct-2512-GGUF --include "*Q4_K_XL*"
hf cache rm -y model/unsloth/Devstral-2-123B-Instruct-2512-GGUF

# hf download --max-workers=$(nproc) mradermacher/GLM-4.6-REAP-218B-A32B-Derestricted-i1-GGUF --include "*IQ2_M*"
hf cache rm -y model/mradermacher/GLM-4.6-REAP-218B-A32B-Derestricted-i1-GGUF

# hf download --max-workers=$(nproc) bartowski/zai-org_GLM-4.7-GGUF --include "*IQ1_M*"
hf cache rm -y model/bartowski/zai-org_GLM-4.7-GGUF
# hf download --max-workers=$(nproc) AaryanK/MiniMax-M2.1-GGUF --include="*q2_k*"
hf cache rm -y model/AaryanK/MiniMax-M2.1-GGUF

# just for fun, Russian Chat models
hf download --max-workers=$(nproc) ai-sage/GigaChat3.1-10B-A1.8B-GGUF --include="*q8*"

hf download --max-workers=$(nproc) t-tech/T-pro-it-2.1-GGUF --include="*Q4_K_M*"
# hf download --max-workers=$(nproc) ai-sage/GigaChat3-10B-A1.8B-GGUF --include="*q8*"
hf cache rm -y model/ai-sage/GigaChat3-10B-A1.8B-GGUF

## for vllm & sglang safetensors
# hf download --max-workers=$(nproc) selimaktas/Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled-v2-NVFP4A16
hf download --max-workers=$(nproc) Qwen/Qwen3.5-35B-A3B-FP8
hf download --max-workers=$(nproc) Qwen/Qwen3.5-27B-FP8
hf download --max-workers=$(nproc) AxionML/Qwen3.5-35B-A3B-NVFP4
# hf cache rm -y model/AxionML/Qwen3.5-35B-A3B-NVFP4
# hf download --max-workers=$(nproc) Kbenkhaled/Qwen3.5-35B-A3B-NVFP4
hf download --max-workers=$(nproc) ig1/Qwen3-Next-80B-A3B-Instruct-NVFP4
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
hf download --max-workers=$(nproc) EssentialAI/rnj-1-instruct

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
hf cache rm -y model noctrex/HyperNova-60B-MXFP4_MOE-GGUF

# hf download --max-workers=$(nproc) juanml82/Huihui-Qwen3-Next-80B-A3B-Thinking-abliterated-gguf
hf cache rm -y model/juanml82/Huihui-Qwen3-Next-80B-A3B-Thinking-abliterated-gguf

# hf download --max-workers=$(nproc) bartowski/Nanbeige_Nanbeige4-3B-Thinking-2511-GGUF --include "*Q8_0*"
hf cache rm -y model/bartowski/Nanbeige_Nanbeige4-3B-Thinking-2511-GGUF

## embedding models
hf download --max-workers=$(nproc) endyjasmi/Qwen3-Embedding-8B-Q4_K_M-GGUF
hf download --max-workers=$(nproc) aiteza/Qwen3-VL-Embedding-8B-GGUF
hf download --max-workers=$(nproc) sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2

## image models ComfyUI
# hf download --max-workers=$(nproc) Comfy-Org/Qwen-Image-Edit_ComfyUI --include "*2511_fp8*" --include "*loras*"
# hf download --max-workers=$(nproc) Comfy-Org/Qwen-Image-Layered_ComfyUI
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
# hf download --max-workers=$(nproc) lightx2v/Wan2.2-Lightning

# guard models to avoid inference attacks
hf download --max-workers=$(nproc) geoffmunn/Qwen3Guard-Stream-8B --include="*Q4_K_M*"

#VLM
# long horizon text
hf download --max-workers=$(nproc) noctrex/Jan-v2-VL-max-MXFP4_MOE-GGUF
hf download --max-workers=$(nproc) noctrex/Qwen3-VL-30B-A3B-Thinking-1M-MXFP4_MOE-GGUF

# Voice
hf download --max-workers=$(nproc) onnx-community/chatterbox-multilingual-ONNX

# OCR
# hf download --max-workers=$(nproc) deepseek-ai/DeepSeek-OCR
hf cache rm -y model/deepseek-ai/DeepSeek-OCR
hf download --max-workers=$(nproc) deepseek-ai/DeepSeek-OCR-2
hf download --max-workers=$(nproc) PaddlePaddle/PaddleOCR-VL-1.5

# small interesting LLMs
hf download --max-workers=$(nproc) LiquidAI/LFM2-2.6B-Exp-GGUF --include="*Q8_0*" #edge-devices 
hf download --max-workers=$(nproc) noctrex/rnj-1-instruct-GGUF --include="*Q8_0*" #coding
# hf download --max-workers=$(nproc) tiiuae/Falcon-H1R-7B-GGUF --include="*Q8_0*" #coding + reasoning
hf cache rm -y model/tiiuae/Falcon-H1R-7B-GGUF


# to have the same /models in all configs outside docker and inside docker
sudo mkdir -p /models
sudo ln -sfn ${HOME}/.cache/huggingface /models/huggingface
sudo chown -R ${USER}:${USER} /models

hf cache ls