# NVIM Configuration

Personal neovim config.

## Requirements

- [Neovim](https://github.com/neovim/neovim) 0.9.0 or later.
- A [Nerdfont](https://www.nerdfonts.com/) patched font.

## Usage

Initialize git repository in `.config` or initialize somewhere else and require
`init.lua`.

To auto install package managers run `init.sh`.

Plugins will auto install and kept updated by lazy.

## Theme

After running `init.sh` an ignored file is created in the `lua/configs`
directory. This file dictates what theme nvim should use, as well as housing any
personal settings.

## WSL

First install [Scoop](https://github.com/ScoopInstaller/Scoop#installation) then
run `scoop install win32yank`. This will install win32yank to
`$USER/scoop/apps/win32yank`. Symlink the win32yank.exe found within to
`/usr/local/bin`. For some reason having win32yank inside WSL makes it very slow
and prone to crash.

If this seems daunting run:

```bash
curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/
```
