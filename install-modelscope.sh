pipx install uv
pipx install modelscope
pipx upgrade-all
if ! ms whoami; then
    ms login
fi