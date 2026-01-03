# if bun installed upgrade all global packages
if command -v bun >/dev/null 2>&1; then
    bun upgrade
    cd ~/.bun/install/global/
    bun update
else 
    curl -fsSL https://bun.sh/install | bash
    sudo ln -sf $(which bun) /usr/local/bin/node
    # echo 'exec bunx "${@//-y /}"' | sudo tee /usr/local/bin/npx > /dev/null
    # sudo chmod +x /usr/local/bin/npx
fi 
