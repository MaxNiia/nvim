#!/bin/bash

# Install rust up 
if ! command -v rustup &> /dev/null
then
    echo "Rustup could not be found, installing"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh 
fi

# Install ripgrep
if ! command -v rg &> /dev/null
then
    echo "rg could not be found, installing"
    cargo install ripgrep
fi

# Install find
if ! command -v fdfind &> /dev/null
then
    echo "fdfind could not be found, installing"
    sudo apt install fd-find
fi

if ! command -v fzf &> /dev/null
then
    echo "fzf not installed, installing"
    sudo apt-get install fzf
fi

if ! command -v nvm &> /dev/null
then
    echo "NVM not installed, installing"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
    echo "If 'nvm install 16' fails copy NVM config from profile file to bashrc"
    nvm install 16
    corepack enable
fi

if ! command -v cspell &> /dev/null
then
    echo "CSPELL is not installed, installing"
    npm install -g cspell
fi


nvim --headless -u NONE -c 'lua require("bootstrap").bootstrap_paq()'

cd ~/.local/share/nvim/site/pack/paqs/start/markdown-preview.nvim/
yarn install

echo ""
