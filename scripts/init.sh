#!/bin/bash

# Install unzip
if ! command -v unzip &>/dev/null; then
    echo "unzip could not be found, installing"
    sudo apt install unzip -y
fi

# Install rust up
if ! command -v rustup &>/dev/null; then
    echo "Rustup could not be found, installing"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

rustup update

# Install ripgrep
if ! command -v rg &>/dev/null; then
    echo "rg could not be found, installing"
    cargo install ripgrep
fi

# Install bat
if ! command -v bat &>/dev/null; then
    echo "bat could not be found, installing"
    sudo apt install bat -y
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
    mkdir -p "$(bat --config-dir)/themes"
    wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
    wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
    wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
    wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
    bat cache --build
    echo "--theme 'Catppuccin Mocha'" >"$HOME/.config/bat/config"
fi

# Install flake8
if ! command -v rg &>/dev/null; then
    echo "flak8 could not be found, installing"
    sudo apt install flake8 -y
fi

if ! command -v fd; then
    echo "fd could not be found installing"
    cargo install fd-find
fi

# Install find
if ! command -v fdfind &>/dev/null; then
    echo "fdfind could not be found, installing"
    sudo apt install fd-find -y
    cargo install fd-find
fi

if ! command -v fzf &>/dev/null; then
    echo "fzf not installed, installing"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    sudo ln -s "$HOME/.fzf/bin/fzf" /usr/bin/fzf
fi

if [ ! -d "${HOME}/.nvm/.git" ]; then
    echo "NVM not installed, installing"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
    echo "If 'nvm install 16' fails copy NVM config from profile file to bashrc"
    nvm install 16
    corepack enable
fi

if ! command -v cspell &>/dev/null; then
    echo "CSPELL is not installed, installing"
    npm install -g cspell
fi

handle_file() {
    local file="$1"
    local content="$2"

    if [ -e "lua/${file##*/}" ]; then
        mv "lua/${file##*/}" "$file"
    fi

    if [ ! -e "$file" ]; then
        # Check if the directory exists else create it
        if [ ! -d "$(dirname "$file")" ]; then
            mkdir -p "$(dirname "$file")"
        fi

        touch "$file"

        if [ ! -w "$file" ]; then
            echo cannot write to "$file"
            exit 1
        fi

        echo -e "$content" >>"$file"
    fi
}

if ! command -v ast-grep &>/dev/null; then
    npm i @ast-grep/cli -g
fi

if ! command -v lua &>/dev/null; then
    echo "Lua not installed, installing"
    sudo apt install -y libreadline-dev
    curl -R -O "https://www.lua.org/ftp/lua-5.1.5.tar.gz"
    ls .
    tar -zxf lua-5.1.5.tar.gz
    (
        cd lua-5.1.5 || exit
        make linux test
        sudo make install
    )
    rm -rf lua-5.1.5
    rm lua-5.1.5.tar.gz
fi

if ! command -v luarocks &>/dev/null; then
    echo "Luarocks not installed, installing"
    wget https://luarocks.github.io/luarocks/releases/luarocks-3.11.1.tar.gz
    tar -zxf luarocks-3.11.1.tar.gz
    (
        cd luarocks-3.11.1 || exit
        ./configure --with-lua-include=/usr/local/include
        make
        sudo make install
    )
    rm -rf luarocks-3.11.1
    rm luarocks-3.11.1.tar.gz
fi

if [ ! -e "${HOME}/.nvimstty" ]; then
    echo "Disabling XON/XOFF flow control"
    touch "${HOME}/.nvimstty &> /dev/null 2>&1"
    echo "stty -ixon" >>"${HOME}/.nvimstty"
    if [ "${SHELL}" = "/usr/bin/zsh" ]; then
        echo "source \"${HOME}/.nvimstty\" &> /dev/null" >>"${HOME}/.zshrc"
    elif [ "${SHELL}" = "/usr/bin/bash" ]; then
        echo "source \"${HOME}/.nvimstty\"" >>"${HOME}/.bashrc"
    else
        echo "Error, can't find suitable shell. Run the following line but change {shellrc} to applicable shell file"
        echo "echo source \"\${HOME}/.nvimstty\" >> \"\${HOME}/.{shellrc}\""
    fi
fi

currentPath="$HOME/.cache"
if [ ! -d "$currentPath" ]; then
    mkdir "$currentPath"
fi

currentPath="$HOME/.cache/nvim"
if [ ! -d "$currentPath" ]; then
    mkdir "$currentPath"
fi

currentPath="$HOME/.cache/nvim/niia.txt"
if [ ! -f "$currentPath" ]; then
    touch "$currentPath"
fi

currentPath="lua/current-theme.lua"
if [ ! -f "$currentPath" ]; then
    touch "$currentPath"
    echo 'vim.cmd("colorscheme catppuccin-mocha")' >"$currentPath"
fi

if [ ! -d "$HOME/venvs" ]; then
    echo "Creating venvs folder"
    mkdir ~/venvs
    python3 -m venv ~/venvs/Debug
    source "$HOME/venvs/Debug/bin/activate"
    echo "Installing requirements"
    python -m pip install -r requirements.txt
    deactivate
fi

# Clear output
echo ""
