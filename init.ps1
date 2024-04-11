# Ensure Scoop is installed
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

# Install Rustup
if (-not (Get-Command rustup -ErrorAction SilentlyContinue)) {
    Write-Host "Rustup could not be found, installing"
    Invoke-WebRequest -Uri https://sh.rustup.rs -OutFile rustup-init.exe
    Start-Process .\rustup-init.exe -ArgumentList '-y' -Wait
    Remove-Item rustup-init.exe
}

# Install ripgrep
if (-not (Get-Command rg -ErrorAction SilentlyContinue)) {
    Write-Host "rg could not be found, installing"
    scoop install ripgrep
}

# Install flake8
if (-not (Get-Command flake8 -ErrorAction SilentlyContinue)) {
    Write-Host "flake8 could not be found, installing"
    scoop install python
    pip install flake8
}

# Install fd (fd-find)
if (-not (Get-Command fd -ErrorAction SilentlyContinue)) {
    Write-Host "fdfind could not be found, installing"
    scoop install fd
}

# Install fzf
if (-not (Get-Command fzf -ErrorAction SilentlyContinue)) {
    Write-Host "fzf not installed, installing"
    scoop install fzf
}

# Install NVM
if (-not (Test-Path "${HOME}/.nvm/.git")) {
    Write-Host "NVM not installed, installing"
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh -OutFile install-nvm.sh
    bash install-nvm.sh
    Remove-Item install-nvm.sh
    Write-Host "If 'nvm install 16' fails copy NVM config from profile file to bashrc"
    nvm install 16
    corepack enable
}

# Install CSPELL
if (-not (Get-Command cspell -ErrorAction SilentlyContinue)) {
    Write-Host "CSPELL is not installed, installing"
    npm install -g cspell
}

Function Handle-File {
    param (
        [String]$file,
        [String]$content
    )

    if (Test-Path "lua/$($file -replace '^.*/', '')") {
        Move-Item "lua/$($file -replace '^.*/', '')" $file
    }

    if (-not (Test-Path $file)) {
        # Check if the directory exists else create it
        if (-not (Test-Path (Split-Path $file -Parent))) {
            New-Item (Split-Path $file -Parent) -ItemType Directory
        }

        New-Item $file -ItemType File

        if (-not ((Get-Item $file).IsReadOnly)) {
            Add-Content $file $content
        } else {
            Write-Host "cannot write to $file"
            exit 1
        }
    }
}

Handle-File "lua/luasnippets/c/hidden.lua" "return {}"
Handle-File "lua/luasnippets/cpp/hidden.lua" "return {}"
Handle-File "lua/luasnippets/cmake/hidden.lua" "return {}"

# Install Lua
if (-not (Get-Command lua -ErrorAction SilentlyContinue)) {
    Write-Host "Lua not installed, installing"
    scoop install lua
}

# Disabling XON/XOFF flow control
if (-not (Test-Path "${HOME}/.nvimstty")) {
    Write-Host "Disabling XON/XOFF flow control"
    New-Item "${HOME}/.nvimstty" -ItemType File
    Add-Content "${HOME}/.nvimstty" "stty -ixon"
    if ($SHELL -eq "/usr/bin/zsh") {
        Add-Content "${HOME}/.zshrc" 'source "${HOME}/.nvimstty"'
    } elseif ($SHELL -eq "/usr/bin/bash") {
        Add-Content "${HOME}/.bashrc" 'source "${HOME}/.nvimstty"'
    } else {
        Write-Host "Error, can't find suitable shell. Run the following line but change {shellrc} to applicable shell file"
        Write-Host 'echo source "${HOME}/.nvimstty" >> "${HOME}/.{shellrc}"'
    }
}

# Creating required directories and files
$currentPath = "$env:LOCALAPPDATA\Temp\"
if (-not (Test-Path $currentPath)) {
    New-Item $currentPath -ItemType Directory
}

$currentPath = "$env:LOCALAPPDATA\Temp\nvim"
if (-not (Test-Path $currentPath)) {
    New-Item $currentPath -ItemType Directory
}

$currentPath = "$env:LOCALAPPDATA\Temp\nvim\niia.txt"
if (-not (Test-Path $currentPath)) {
    New-Item $currentPath -ItemType File
}

if (-not (Test-Path "$HOME/venvs")) {
    Write-Host "Creating venvs folder"
    New-Item "$HOME/venvs" -ItemType Directory
    python3 -m venv "$HOME/venvs/Debug"
    . "$HOME/venvs/Debug/bin/Activate.ps1"
    Write-Host "Installing requirements"
    python -m pip install -r requirements.txt
    deactivate
}
