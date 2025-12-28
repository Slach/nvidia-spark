# CODING MODELS
## for llama.cpp GGUF
hf download --max-workers=$(nproc) noctrex/MiniMax-M2-REAP-139B-A10B-MXFP4_MOE-GGUF
hf download --max-workers=$(nproc) noctrex/Qwen3-Next-80B-A3B-Instruct-1M-MXFP4_MOE-GGUF
hf download --max-workers=$(nproc) noctrex/GLM-4.6V-MXFP4_MOE-GGUF
hf download --max-workers=$(nproc) unsloth/Devstral-2-123B-Instruct-2512-GGUF --include "*Q4_K_XL*"
hf download --max-workers=$(nproc) mradermacher/GLM-4.6-REAP-218B-A32B-Derestricted-i1-GGUF --include "*IQ2_M*"
hf download --max-workers=$(nproc) bartowski/zai-org_GLM-4.7-GGUF --include "*IQ1_M*"
hf download --max-workers=$(nproc) AaryanK/MiniMax-M2.1-GGUF --include="*q2_k*"

# just for fun, Russian Chat models
hf download --max-workers=$(nproc) ai-sage/GigaChat3-10B-A1.8B-GGUF --include="%q8%"
hf download --max-workers=$(nproc) t-tech/T-pro-it-2.1-GGUF --include="*Q4_K_M*"

## for vllm  safetensors
hf download --max-workers=$(nproc) Qwen/Qwen3-Coder-30B-A3B-Instruct-FP8
hf download --max-workers=$(nproc) unsloth/Qwen3-Next-80B-A3B-Instruct-bnb-4bit
hf download --max-workers=$(nproc) ig1/Qwen3-Next-80B-A3B-Instruct-NVFP4
hf download --max-workers=$(nproc) nvidia/NVIDIA-Nemotron-3-Nano-30B-A3B-FP8
hf download --max-workers=$(nproc) EssentialAI/rnj-1-instruct
hf download --max-workers=$(nproc) ArliAI/GLM-4.5-Air-Derestricted-GPTQ-Int4-Int8-Mixed

## single GGUF can be used with vLLM + llama.cpp
hf download --max-workers=$(nproc) noctrex/Nemotron-3-Nano-30B-A3B-MXFP4_MOE-GGUF
hf download --max-workers=$(nproc) juanml82/Huihui-Qwen3-Next-80B-A3B-Thinking-abliterated-gguf

## embedding models
hf download --max-workers=$(nproc) endyjasmi/Qwen3-Embedding-8B-Q4_K_M-GGUF

## image models ComfyUI
hf download --max-workers=$(nproc) Comfy-Org/Qwen-Image-Edit_ComfyUI --include "*2511*" --include "*2509*"
hf download --max-workers=$(nproc) unsloth/Qwen-Image-Edit-2511-GGUF --include="*Q4_K_M*"
hf download --max-workers=$(nproc) Comfy-Org/Qwen-Image-Layered_ComfyUI
hf download --max-workers=$(nproc) Comfy-Org/flux2-dev --exclude "*bf16*"
hf download --max-workers=$(nproc) lightx2v/Qwen-Image-Edit-2511-Lightning

## video+image models ComfyUI + diffusers custom nodes
hf download --max-workers=$(nproc) kandinskylab/Kandinsky-5.0-I2V-Pro-distilled-5s-Diffusers
hf download --max-workers=$(nproc) kandinskylab/Kandinsky-5.0-T2V-Pro-distilled-5s-Diffusers
hf download --max-workers=$(nproc) kandinskylab/Kandinsky-5.0-I2I-Lite-sft-Diffusers
hf download --max-workers=$(nproc) kandinskylab/Kandinsky-5.0-T2I-Lite-sft-Diffusers

# animation + video
hf download --max-workers=$(nproc) Wan-AI/Wan2.2-Animate-14B
hf download --max-workers=$(nproc) lightx2v/Wan2.2-Lightning

# guard models to avoid inference attacks
hf download --max-workers=$(nproc) geoffmunn/Qwen3Guard-Stream-8B --include="*Q4_K_M*"

#VLM
hf download --max-workers=$(nproc) noctrex/Jan-v2-VL-max-MXFP4_MOE-GGUF
hf download --max-workers=$(nproc) noctrex/Qwen3-VL-30B-A3B-Thinking-1M-MXFP4_MOE-GGUF

# Voice
hf download --max-workers=$(nproc) onnx-community/chatterbox-multilingual-ONNX

# OCR
hf download --max-workers=$(nproc) deepseek-ai/DeepSeek-OCR

# small LLMs
hf download --max-workers=$(nproc) LiquidAI/LFM2-2.6B-Exp-GGUF --include="*Q8_0*"

# to have the same /models in all configs
sudo mkdir -p /models
sudo ln -sfn ${HOME}/.cache/huggingface /models/huggingface
sudo chown -R ${USER}:${USER} /models
