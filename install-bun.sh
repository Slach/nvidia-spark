if command -v bun >/dev/null 2>&1; then
    bun upgrade
else 
    curl -fsSL https://bun.sh/install | bash
    sudo ln -sf $(which bun) /usr/local/bin/node
    echo 'bunx "${@}"' | sudo tee /usr/local/bin/npx > /dev/null
    sudo chmod +x /usr/local/bin/npx
fi 
