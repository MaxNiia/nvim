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

if [ ! -d "${HOME}/.nvm/.git" ]
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

file="lua/user.lua"

if [ ! -e "$file" ] ; then
    touch "$file"
    echo "require('catppuccin')" >> "$file"
    echo "-- require('nightfox')" >> "$file"
fi

if [ ! -w "$file" ] ; then
    echo cannot write to $file
    exit 1
fi

if ! command -v lua &> /dev/null
then
    echo "Lua not installed, installing"
    sudo apt install lua
fi

if ! command -v nvr &> /dev/null
then 
    echo "NVR not installed installing"
    pip3 install neovim-remote
    git config --global core.editor 'nvr --remote-wait-silent'
fi

# Clear output
echo ""
