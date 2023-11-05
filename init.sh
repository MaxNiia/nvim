#!/bin/bash

# This script installs various programming tools and sets up the environment.
# It checks for the existence of each tool and installs it if not found.
# Additionally, it creates and configures necessary files and directories.
#
# Tools installed:
# - rustup (Rust toolchain installer)
# - ripgrep (rg, a line-oriented search tool)
# - fd-find (fdfind, a simple, fast and user-friendly alternative to 'find')
# - fzf (a general-purpose command-line fuzzy finder)
# - nvm (Node Version Manager)
# - cspell (a spell checker for code)
# - lua (Lua programming language)
# - dotnet-sdk-7.0 (C# SDK, optional, installed if "c#" is passed as an argument)
#
# Files and directories created and configured:
# - lua/configs/user.lua (configuration file for user settings)
# - lua/configs/ai_backend.lua (configuration file for AI backend)
# - ~/.nvimstty (disables XON/XOFF flow control)
# - ~/venvs (creates a virtual environment for Python debugging)
#
# Errors:
# - If a file cannot be written to, the script will exit with an error message.
# - If a suitable shell is not found for disabling XON/XOFF flow control, an error message is displayed with instructions.
#
# Usage:
#   ./install.sh [c#]
#   - Pass "c#" as an argument to install the C# SDK.

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

# Define a function to handle common parts
handle_file() {
    local file="$1"
    local content="$2"

    if [ -e "lua/${file##*/}" ] ; then
        mv "lua/${file##*/}" "$file"
    fi

    if [ ! -e "$file" ] ; then
        touch "$file"

        if [ ! -w "$file" ] ; then
            echo cannot write to "$file"
            exit 1
        fi

        echo -e "$content" >> "$file"
    fi
}

# Call the function for user.lua
handle_file "lua/configs/user.lua" "require('catppuccin')\n-- require('nightfox')"

# Call the function for ai_backend.lua
handle_file "lua/configs/ai_backend.lua" "return 'https://api.openai.com/v1/engines/cushman-codex/completions'"

if ! command -v lua &> /dev/null
then
    echo "Lua not installed, installing"
    sudo apt install lua5.3
fi

if [ ! -e "${HOME}/.nvimstty" ] ; then
    echo "Disabling XON/XOFF flow control"
    touch "${HOME}/.nvimstty"
    echo "stty -ixon" >> "${HOME}/.nvimstty"
    if [ "${SHELL}" = "/usr/bin/zsh" ] ; then
        echo "source \"${HOME}/.nvimstty\"" >> "${HOME}/.zshrc"
    elif [ "${SHELL}" = "/usr/bin/bash" ] ; then
        echo "source \"${HOME}/.nvimstty\"" >> "${HOME}/.bashrc"
    else 
        echo "Error, can't find suitable shell. Run the following line but change {shellrc} to applicable shell file"
        echo "echo source \"\${HOME}/.nvimstty\" >> \"\${HOME}/.{shellrc}\""
    fi
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

for arg in "$@"; do
    if [ "$arg" = "c#" ]; then
        sudo apt install ca-certificates gnupg
        sudo gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
        echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
        sudo apt update
        sudo apt install mono-devel
        sudo apt install mono-complete
    fi
done

# Clear output
echo ""
