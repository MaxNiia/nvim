# Bare Neovim Config

A minimal, modern Neovim configuration built for Neovim v0.12.0-nightly with native package management.

## Features

- **Native package management** - Uses Neovim's built-in `vim.pack` (no external plugin managers)
- **LSP support** - Multiple language servers configured
- **Auto-formatting** - Format on save for supported languages
- **Auto-save** - Debounced auto-save on buffer leave and insert leave
- **Git integration** - Gitsigns for git change indicators
- **Advanced editing** - Multi-cursor, treesitter, blink.cmp completion

## Quick Start

```bash
# Clone the repository
git clone https://github.com/MaxNiia/nvim ~/.config/nvim

# Install LSPs
cd ~/.config/nvim
make install

# Create symlink (if not already using this path)
ln -s ~/.config/nvim ~/.config/nvim

# Launch Neovim
nvim
```

On first launch, plugins will be installed automatically via `:Pack` commands.

## Prerequisites

### Required

- **Neovim** v0.12.0-nightly or later
- **Git** - For cloning plugins
- **wget** or **curl** - For downloading LSPs
- **tar/unzip** - For extracting archives

### For LSP Installation

- **pipx** - Python package installer
- **npm** - Node.js package manager
- **cargo** - Rust package manager

Install prerequisites:

```bash
# Ubuntu/Debian
sudo apt install pipx nodejs npm
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# macOS
brew install pipx node rust

# Arch Linux
sudo pacman -S python-pipx nodejs npm rust
```

## Installation

Check [install](install..md)

## Supported LSPs

| Language Server | Languages | Install Command |
|----------------|-----------|-----------------|
| [lua_ls](https://github.com/LuaLS/lua-language-server) | Lua | `make install-lua-ls` |
| [clangd](https://github.com/clangd/clangd) | C/C++ | `make install-clangd` |
| [basedpyright](https://github.com/DetachHead/basedpyright) | Python | `make install-basedpyright` |
| [typos-lsp](https://github.com/tekumara/typos-lsp) | Spell checking | `make install-typos-lsp` |
| [dockerls](https://github.com/mayflower/docker-ls) | Dockerfile | `make install-dockerls` |
| [jsonls](https://github.com/hrsh7th/vscode-langservers-extracted) | JSON | `make install-jsonls` |
| [marksman](https://github.com/artempyanykh/marksman) | Markdown | `make install-marksman` |
| [azure-pipelines-ls](https://github.com/microsoft/azure-pipelines-language-server) | Azure Pipelines | `make install-azure-pipelines-ls` |
| [cmake-ls](https://github.com/regen100/cmake-language-server) | CMake | `make install-cmake-ls` |
| [starlark-lsp](https://github.com/facebookexperimental/starlark-rust/) | Bazel/Starlark | `make install-starlark-lsp` |

## Configuration

### Directory Structure

```
~/.config/bare-nvim/
├── init.lua              # Entry point
├── lua/
│   ├── plugins.lua       # Plugin definitions
│   ├── lsp.lua          # LSP configuration
│   ├── keybinds.lua     # Key mappings
│   ├── option.lua       # Neovim options
│   ├── command/         # Custom commands
│   └── ado/             # ADO integration
├── plugin/              # Plugin configs (lazy-loaded)
├── after/               # After directory
├── lsp/                 # LSP specific configs
├── snippets/            # Custom snippets
├── Makefile             # LSP installation
└── nvim-pack-lock.json  # Plugin lock file
```

### Key Mappings

Leader key: `<Space>`
Local leader: `,`

Use `<Space>` in normal mode to open which-key menu for available keybindings.

Common mappings:
- `H` / `L` - Start/end of line
- `<C-h/j/k/l>` - Navigate windows
- `<leader>y` / `<leader>p` - System clipboard
- `<leader>k` - Show diagnostics
- `Q` - Save and quit buffer

### Customization

**Disable auto-format:**
```vim
:let g:autoformat = 0        " Globally
:let b:autoformat = 0        " Current buffer
```

or using snacks with

```lua
'<space>uf' -- Globally
'<space>uF' -- Current buffer
```

**Change colorscheme flavor:**
Edit `plugin/catppuccin.lua` and change `flavour` option.

**Add new LSP:**
1. Add install target to `Makefile`
2. Add LSP name to `lua/lsp.lua` in `vim.lsp.enable()`
3. Run `make install-<lsp-name>`

## Plugin Management

This config uses Neovim's native package management via custom `:Pack` commands.

**Update all plugins:**
```vim
:Pack update
```

**Add a plugin:**
Edit `lua/plugins.lua` and add to the `packages` table:
```lua
{
    src = "https://github.com/user/plugin",
    name = "plugin-name",
    version = "main",
}
```

**Remove a plugin:**
Remove from `lua/plugins.lua` and restart Neovim (auto-cleaned).

## Development

### Running Tests

```bash
# Run pre-commit checks
pre-commit run --all-files

# Run Lua syntax check
make check-lua

# Validate config
nvim --headless +"checkhealth" +"quit"
```

### CI/CD

GitHub Actions workflows:
- **Lint** - Runs pre-commit hooks
- **Validate** - Checks JSON, Lua syntax, plugin duplicates
- **Health Check** - Runs checkhealth, fails on deprecations

## Troubleshooting

**Plugins not loading:**
```vim
:Pack update
```

**LSP not attaching:**
- Verify LSP installed: `which <lsp-name>`
- Check LSP logs: `:LspLog`
- Run health check: `:checkhealth`

**Completion not working:**
- Ensure blink.cmp is installed
- Check `:checkhealth blink`

**Formatting not working:**
- Check if LSP supports formatting: `:lua =vim.lsp.buf_get_clients()[1].server_capabilities.documentFormattingProvider`
- Verify `g:autoformat` and `b:autoformat` are true

## External Configuration

### clangd Query Driver

Set the compiler paths for clangd:
```vim
let g:clangd_query_driver = "/usr/bin/clang,/usr/bin/clang++"
```

### Copyright Text

Customize copyright header:
```vim
let g:copyright_text = ["Copyright", "Year: 2024"]
```

### Background

Set light/dark mode via environment variable:
```bash
export NVIM_BACKGROUND=dark  # or "light"
```

## License

Personal configuration - use as you wish.
