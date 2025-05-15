#!/usr/bin/env bash

set -e

# UTILS
# ------------------------------------------------------------------------------
apt_install() {
    if [ $# -eq 0 ]; then
        echo "No arguments provided to '${FUNCNAME[0]}'."
        exit 2
    fi

    apt_upgrade=()
    apt_install=()

    for var in "$@"; do
        if ! command -v $var &>/dev/null; then
            echo "Installing '$var'."
            apt_install+=("$var")
        else
            echo "Updating '$var'."
            apt_upgrade+=("$var")
        fi
    done

    sudo apt update
    sudo apt upgrade -y "${apt_upgrade[@]}"
    sudo apt install -y "${apt_install[@]}"
}

pipx_install() {
    if [ $# -lt 1 ]; then
        echo "No arguments provided to '${FUNCNAME[0]}'."
        exit 2
    fi

    if [ $# -eq 2 ]; then
        echo "Installing '$1'."
        pipx install "$1"=="$2" --force
    else
        echo "Installing '$1'."
        pipx install "$1"
    fi

}

npm_install() {
    if [ ! $# -eq 1 ]; then
        echo "No arguments provided to '${FUNCNAME[0]}'."
        exit 2
    fi

    if ! command -v $1 &>/dev/null; then
        echo "Installing '$1'."
        npm install -g $1
    else
        npm update -g $1
    fi
}

create_dir() {
    if [ ! $# -eq 1 ]; then
        echo "'${FUNCNAME[0]}' required a directory input."
        exit 2
    fi

    if [ ! -d "$1" ]; then
        mkdir $1
        echo "$1 created."
    fi
}

git_update() {
    if [ ! $# -gt 1 ]; then
        echo "Not enough arguments provided to '${FUNCNAME[0]}'."
        exit 2
    fi

    if [ ! -d "$2" ]; then
        git clone "$1" "$2"
    fi

    cd "$2"
    git fetch
    if [ $# -eq 3 ]; then
        git checkout "$3"
    else
        git pull
    fi
    git submodule update --recursive --init
    cd -
}

cargo_install() {
    if [ ! $# -eq 1 ]; then
        echo "No arguments provided to '${FUNCNAME[0]}'."
        exit 2
    fi

    cargo install --locked $1
}
# ------------------------------------------------------------------------------

apt_install \
    gettext \
    curl \
    build-essential \
    unzip \
    libreadline-dev \
    diffstat \
    pipx

# INSTALLER
# ------------------------------------------------------------------------------
pipx ensurepath

if ! command -v rustup &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
    rustup update
fi

if ! command -v fnm &>/dev/null; then
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
    # shellcheck source=../../.bashrc
    source "$HOME/.bashrc"
fi

if ! command -v uv &>/dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    uv self update
fi

fnm install 23
fnm use 23
# ------------------------------------------------------------------------------

if [ ! -e "${HOME}/.nvimstty" ]; then
    echo "Disabling XON/XOFF flow control"
    touch "${HOME}/.nvimstty" &>/dev/null
    echo "stty -ixon" >>"${HOME}/.nvimstty"
    if [ "${SHELL}" = "/usr/bin/zsh" ]; then
        echo "source \"${HOME}/.nvimstty\" &> /dev/null" >>"${HOME}/.zshrc"
    elif [ "${SHELL}" = "/usr/bin/bash" ]; then
        echo "source \"${HOME}/.nvimstty\"" >>"${HOME}/.bashrc"
    elif [ "${SHELL}" = "/bin/bash" ]; then
        echo "source \"${HOME}/.nvimstty\"" >>"${HOME}/.bashrc"
    else
        echo "Error, can't find suitable shell. Run the following line but change {shellrc} to applicable shell file"
        echo "echo source \"\${HOME}/.nvimstty\" >> \"\${HOME}/.{shellrc}\""
    fi
fi

cargo_install ripgrep
cargo_install fd-find
cargo_install git-delta
pipx_install debugpy
npm_install @ast-grep/cli
apt_install libfuse2

# Lua.
LUA_VERSION="5.1.5"
lua_version=""
if command -v lua &>/dev/null; then
    lua_version=$(lua -v 2>&1 | awk '{print $2}')
fi

if [ "$lua_version" != "$LUA_VERSION" ]; then
    echo "Lua not installed, installing"
    sudo apt install -y libreadline-dev
    curl -R -O "https://www.lua.org/ftp/lua-$LUA_VERSION.tar.gz"
    tar -zxf "lua-$LUA_VERSION.tar.gz"
    (
        cd lua-$LUA_VERSION || exit
        make linux test
        sudo make install
    )
    rm -rf lua-$LUA_VERSION
    rm lua-$LUA_VERSION.tar.gz
fi

LUAROCKS_VERSION="3.11.1"
luarocks_version=""
if command -v luarocks &>/dev/null; then
    luarocks_version=$(luarocks --version | head -n1 | grep -oP '\d+\.\d+\.\d+')
fi
if [ "$luarocks_version" != "$LUAROCKS_VERSION" ]; then
    echo "Luarocks not installed, installing"
    wget "https://luarocks.github.io/luarocks/releases/luarocks-$LUAROCKS_VERSION.tar.gz"
    tar -zxf "luarocks-$LUAROCKS_VERSION.tar.gz"
    (
        cd "luarocks-$LUAROCKS_VERSION" || exit
        ./configure && make && sudo make install
    )
    rm -rf "luarocks-$LUAROCKS_VERSION"
    rm "luarocks-$LUAROCKS_VERSION.tar.gz"
fi

# Lazygit integration.
lazygit_version=""
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
if command -v lazygit &>/dev/null; then
    lazygit_version=$(lazygit --version | head -n1 | grep -oP '\d+\.\d+\.\d+')
fi
if [ "$lazygit_version" != "$LAZYGIT_VERSION" ]; then
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit -D -t /usr/local/bin/
    rm -rf lazygit
    rm lazygit.tar.gz
fi

APPLICATIONS="$HOME/applications"
create_dir "$APPLICATIONS"
NEOVIM_DIR="neovim"
neovim_version="a81d2b6703e03bcee0521772551df750148884ae" # v0.12.0 nightly
(
    cd "$APPLICATIONS"
    if [ ! -d "$NEOVIM_DIR" ]; then
        git_update https://github.com/neovim/neovim.git "$NEOVIM_DIR" $neovim_version
        cd "$NEOVIM_DIR"
        sudo rm -rf .deps build docs
        make CMAKE_BUILD_TYPE=Release && sudo make install
    else
        cd "$NEOVIM_DIR"
        current_neovim_version=$(git rev-parse HEAD)
        if [ "$neovim_version" != "$current_neovim_version" ]; then
            git fetch --all --tags --force
            cd ..
            git_update https://github.com/neovim/neovim.git "$NEOVIM_DIR" $neovim_version
            cd "$NEOVIM_DIR"
            sudo rm -rf .deps build docs
            make CMAKE_BUILD_TYPE=Release && sudo make install
        fi
    fi
)

# Make fzf only install if changed.
FZF_DIR="fzf"
fzf_version="d226d841a1f2b849b7e3efab2a44ecbb3e61a5a5"
(
    cd "$APPLICATIONS"
    if [ ! -d "$FZF_DIR" ]; then
        echo "firsttime"
        git_update https://github.com/junegunn/fzf.git "$FZF_DIR" $fzf_version
        "$FZF_DIR/install"
    fi

    cd "$FZF_DIR"
    if [ ! "$fzf_version" = "$(git rev-parse HEAD)" ]; then
        git fetch --all --tags --force
        cd ..
        echo "update"
        git_update https://github.com/junegunn/fzf.git "$FZF_DIR" $fzf_version
        "$FZF_DIR/install"
    fi
)

wget https://imagemagick.org/archive/binaries/magick
create_dir "$APPLICATIONS/magick"
sudo chmod +x magick
mv magick "$APPLICATIONS/magick/magick"
