import os
import re

TARGET_DIR = "/usr/local/lib/python3.12/dist-packages/paroquant"

for root, dirs, files in os.walk(TARGET_DIR):
    for file in files:
        if not file.endswith(".py"):
            continue

        path = os.path.join(root, file)
        with open(path, "r", encoding="utf-8") as f:
            content = f.read()

        # Patch 1: maybe_update_config — add **kwargs
        if "def maybe_update_config(" in content and "kwargs" not in content:
            new_content = re.sub(
                r"(def maybe_update_config\s*\([^)]+)(\))", r"\1, **kwargs\2", content
            )
            with open(path, "w", encoding="utf-8") as f:
                f.write(new_content)
            print(f"Successfull patched: {path}")

# Patch 2: cli/serve.py — force VLLM_WORKER_MULTIPROC_METHOD=spawn before vLLM import
# This prevents "Cannot re-initialize CUDA in forked subprocess" error
serve_path = os.path.join(TARGET_DIR, "cli", "serve.py")
if os.path.exists(serve_path):
    with open(serve_path, "r", encoding="utf-8") as f:
        content = f.read()

    if "VLLM_WORKER_MULTIPROC_METHOD" not in content:
        # Insert spawn enforcement right after def _serve_vllm():
        content = content.replace(
            "def _serve_vllm():\n",
            'def _serve_vllm():\n    import os\n    os.environ.setdefault("VLLM_WORKER_MULTIPROC_METHOD", "spawn")\n',
        )
        with open(serve_path, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"Successfull patched spawn method: {serve_path}")
