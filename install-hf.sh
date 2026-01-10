pipx install -U uv
pipx install -U huggingface_hub[cli]
hf auth

grep -q -F "HF_XET_HIGH_PERFORMANCE" ~/.bashrc || echo "export HF_XET_HIGH_PERFORMANCE=1" >> ~/.bashrc