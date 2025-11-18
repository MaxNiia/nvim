# Installation Guide

Complete installation guide for bare-nvim configuration.

## Table of Contents

1. [System Requirements](#system-requirements)
2. [Installing Prerequisites](#installing-prerequisites)
3. [Installing Neovim Nightly](#installing-neovim-nightly)
4. [Installing the Configuration](#installing-the-configuration)
5. [Installing Language Servers](#installing-language-servers)
6. [Verifying Installation](#verifying-installation)
7. [Platform-Specific Notes](#platform-specific-notes)

## System Requirements

- **OS**: Linux, macOS, or WSL2
- **Neovim**: v0.12.0-nightly or later
- **Git**: 2.0 or later
- **Terminal**: True color support recommended

## Installing Prerequisites

### Ubuntu/Debian

```bash
# Update package list
sudo apt update

# Install basic tools
sudo apt install -y git curl wget unzip tar

# Install Python tools
sudo apt install -y python3 python3-pip python3-venv
pip3 install --user pipx
pipx ensurepath

# Install Node.js (via NodeSource)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
```

### macOS

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install prerequisites
brew install git curl wget
brew install pipx
brew install node
brew install rust

# Ensure pipx is in PATH
pipx ensurepath
```

### Arch Linux

```bash
# Install prerequisites
sudo pacman -S git curl wget unzip tar
sudo pacman -S python-pipx nodejs npm rust

# Ensure pipx is in PATH
pipx ensurepath
```

### Fedora/RHEL

```bash
# Install basic tools
sudo dnf install -y git curl wget unzip tar

# Install Python tools
sudo dnf install -y python3 python3-pip
pip3 install --user pipx
pipx ensurepath

# Install Node.js
sudo dnf install -y nodejs npm

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
```

**After installing prerequisites, restart your shell or run:**
```bash
source ~/.bashrc  # or ~/.zshrc
```

## Installing Neovim Nightly

### Option 1: AppImage (Linux - Recommended)

```bash
# Download the latest nightly AppImage
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage

# Make it executable
chmod +x nvim-linux-x86_64.appimage

# Move to a directory in your PATH
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim

# Verify installation
nvim --version
```

### Option 2: Package Manager

**macOS (Homebrew):**
```bash
brew install --HEAD neovim
```

**Arch Linux:**
```bash
# Install from AUR
yay -S neovim-git
# or
paru -S neovim-git
```

**Ubuntu/Debian (PPA):**
```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```

### Option 3: Build from Source

```bash
# Install build dependencies (Ubuntu/Debian)
sudo apt install -y ninja-build gettext cmake unzip curl build-essential

# Clone repository
git clone https://github.com/neovim/neovim
cd neovim

# Build (Release with debug info)
make CMAKE_BUILD_TYPE=RelWithDebInfo

# Install
sudo make install

# Verify
nvim --version
```

## Installing the Configuration

### Step 1: Backup Existing Configuration (if any)

```bash
# Backup current Neovim config
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
```

### Step 2: Clone Repository

```bash
# Clone to the standard Neovim config location
git clone <your-repo-url> ~/.config/nvim

# Or clone to custom location and symlink
git clone <your-repo-url> ~/.config/bare-nvim
ln -s ~/.config/bare-nvim ~/.config/nvim
```

### Step 3: Verify Structure

```bash
cd ~/.config/nvim
ls -la
```

You should see: `init.lua`, `lua/`, `plugin/`, `Makefile`, etc.

## Installing Language Servers

### Check Package Manager Availability

```bash
cd ~/.config/nvim
make check
```

This verifies that `pipx`, `npm`, `cargo`, and `wget` are installed.

### Install All LSPs

```bash
make install
```

This will install all language servers. **Note**: This may take 10-30 minutes depending on your internet connection.

### Install Specific LSPs

Install only the LSPs you need:

```bash
# Essential LSPs
make install-lua-ls       # Lua (for Neovim config)
make install-basedpyright # Python
make install-clangd       # C/C++

# Optional LSPs
make install-jsonls       # JSON
make install-marksman     # Markdown
make install-dockerls     # Docker
make install-typos-lsp    # Spell checking

# See all targets
make help
```

### Manual LSP Installation

If `make install` fails, you can install LSPs manually:

**Lua Language Server:**
```bash
mkdir -p ~/.local/share/nvim-lsp/lua-ls
cd ~/.local/share/nvim-lsp/lua-ls
wget https://github.com/LuaLS/lua-language-server/releases/latest/download/lua-language-server-linux-x64.tar.gz
tar -xzf lua-language-server-linux-x64.tar.gz
ln -s ~/.local/share/nvim-lsp/lua-ls/bin/lua-language-server ~/.local/bin/
```

**Python (basedpyright):**
```bash
pipx install basedpyright
```

**TypeScript/JavaScript:**
```bash
npm install -g typescript typescript-language-server
```

## Verifying Installation

### Step 1: Launch Neovim

```bash
nvim
```

On first launch, plugins will be installed automatically. This may take 1-2 minutes.

### Step 2: Check Health

```vim
:checkhealth
```

Review the output for any errors or warnings.

### Step 3: Verify Plugins

```vim
:Pack status
```

Should show all plugins installed.

### Step 4: Verify LSPs

Open a file and check LSP status:

```vim
:LspInfo
```

Should show attached language servers for the file type.

### Step 5: Test Completion

1. Open a Lua file: `:e test.lua`
2. Type: `vim.`
3. You should see completion popup

### Step 6: Test Formatting

1. Make some changes to a file
2. Save: `:w`
3. File should auto-format if LSP supports it

## Platform-Specific Notes

### Linux

- Ensure `~/.local/bin` is in your PATH
- Add to `~/.bashrc` or `~/.zshrc`:
  ```bash
  export PATH="$HOME/.local/bin:$PATH"
  ```

### macOS

- Use Homebrew for most dependencies
- Some LSPs may require Xcode Command Line Tools:
  ```bash
  xcode-select --install
  ```

### WSL2 (Windows Subsystem for Linux)

- Follow Ubuntu/Debian instructions
- For clipboard integration, install `win32yank`:
  ```bash
  curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
  unzip /tmp/win32yank.zip -d ~/.local/bin/
  chmod +x ~/.local/bin/win32yank.exe
  ```

## Optional Setup

### Install Pre-commit Hooks

```bash
cd ~/.config/nvim
pip install pre-commit
pre-commit install
```

## Troubleshooting Installation

### Plugins Not Installing

```bash
# Remove plugin cache and reinstall
rm -rf ~/.local/state/nvim/pack
nvim +"Pack install" +quit
```

### LSP Not Found

```bash
# Check if LSP binary is in PATH
which lua-language-server
which clangd
which basedpyright

# Add to PATH if needed
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Build Errors (Blink.cmp)

Blink.cmp requires building on first install:
```bash
# Install build dependencies
sudo apt install -y build-essential  # Ubuntu/Debian
brew install gcc                      # macOS

# Rebuild blink.cmp
nvim +"lua require('blink.cmp.fuzzy.build').build()" +quit
```

### Rust Installation Issues

```bash
# Ensure Rust is in PATH
source "$HOME/.cargo/env"

# Update Rust
rustup update
```

## Post-Installation

After successful installation:

1. **Learn keybindings**: Press `<space>` in normal mode to see which-key menu
2. **Customize**: Edit files in `~/.config/nvim/plugin/` for plugin settings
3. **Add LSPs**: Edit `lua/lsp.lua` and `Makefile` to add more language servers

## Getting Help

If you encounter issues:

1. Run `:checkhealth` in Neovim
2. Check `:messages` for errors
3. Review `:LspLog` for LSP issues
4. Check plugin GitHub issues
5. Ensure all prerequisites are installed

## Updating

To update the configuration and plugins:

```bash
cd ~/.config/nvim

# Update config
git pull

# Update plugins
nvim +"Pack update" +quit

# Update LSPs
make install
```
