pipx install uv
pipx install huggingface_hub
pipx upgrade-all
if [[ $(hf auth list | grep -c -E "^\*.+hf_") == "0" ]]; then
    hf auth login
fi 

grep -q -F "HF_XET_HIGH_PERFORMANCE" ~/.bashrc || echo "export HF_XET_HIGH_PERFORMANCE=1" >> ~/.bashrc