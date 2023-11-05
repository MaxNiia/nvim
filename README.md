# NVIM Configuration

Repository for keeping different versions of nvim configurations.

- Profiles: Switch on.
- - User
- - Epiroc, if NVIM_EPIROC environment variable is set.

## Usage

Initialize git repository in `.config` or initialize somewhere else and require
`init.lua`.

To auto install packages run `init.sh`.

## WSL
If using wsl the windows clipboard has to be installed in order to yank
into and put from windows. The following command from the neovim FAQ
does exactly that.
`bash
curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/
`

## TODO
Look at telescope project/browser.

