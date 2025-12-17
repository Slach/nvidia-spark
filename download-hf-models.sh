# for llama.cpp GGUF
hf download --max-workers=$(nproc) noctrex/MiniMax-M2-REAP-139B-A10B-MXFP4_MOE-GGUF
hf download --max-workers=$(nproc) noctrex/Qwen3-Next-80B-A3B-Instruct-1M-MXFP4_MOE-GGUF
# single GGUF can be used with vLLM
hf download --max-workers=$(nproc) noctrex/Nemotron-3-Nano-30B-A3B-MXFP4_MOE-GGUF
# for vllm  safetensors
hf download --max-workers=$(nproc) Qwen/Qwen3-Coder-30B-A3B-Instruct-FP8
hf download --max-workers=$(nproc) unsloth/Qwen3-Next-80B-A3B-Instruct-bnb-4bit
hf download --max-workers=$(nproc) ig1/Qwen3-Next-80B-A3B-Instruct-NVFP4
hf download --max-workers=$(nproc) juanml82/Huihui-Qwen3-Next-80B-A3B-Thinking-abliterated-gguf
hf download --max-workers=$(nproc) nvidia/NVIDIA-Nemotron-3-Nano-30B-A3B-FP8
