# NVIM Configuration

Personal neovim config.

## Requirements

- [Neovim](https://github.com/neovim/neovim) 0.10.0 (nightly) or later.
- A [Nerdfont](https://www.nerdfonts.com/) patched font.
- Everything in the init script files. Either run the init.sh on linux or the
init.ps1 file on windows. Or just install the packages there.

## Usage

Initialize git repository in `.config` or initialize somewhere else and require
`init.lua`.

Plugins will auto install and kept updated by lazy.

## WSL

Install win32yank in WSL, in order to copy/paste from windows.

```bash
curl -s /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/
```
