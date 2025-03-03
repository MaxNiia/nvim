# Ensure Scoop is installed
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

if (-not (Get-Command rg -ErrorAction SilentlyContinue)) {
    scoop install rustup
}
else {
    scoop update rustup
}

if (-not (Get-Command unzip -ErrorAction SilentlyContinue)) {
    scoop install unzip
}
else {
    scoop update unzip
}

if (-not (Get-Command curl -ErrorAction SilentlyContinue)) {
    scoop install curl
}
else {
    scoop update curl
}

rustup update

# Install ripgrep
if (-not (Get-Command rg -ErrorAction SilentlyContinue)) {
    Write-Host "rg could not be found, installing"
    scoop install ripgrep
else {
    scoop update ripgrep
}

# Install lazygit
if (-not (Get-Command rg -ErrorAction SilentlyContinue)) {
    Write-Host "lazygit could not be found, installing"
    # Add the extras bucket
    scoop bucket add extras

    scoop install lazygit
} else {
    scoop update lazygit
}

# Install pipx
if (-not (Get-Command pipx -ErrorAction SilentlyContinue)) {
    Write-Host "lazygit could not be found, installing"
    scoop install pipx
} else {
    scoop update pipx
}

# Install fd (fd-find)
if (-not (Get-Command fd -ErrorAction SilentlyContinue)) {
    Write-Host "fdfind could not be found, installing"
    scoop install fd
} else {
    scoop update fd
}

# Install fnm
if (-not (Get-Command fnm -ErrorAction SilentlyContinue)) {
    Write-Host "fnm could not be found, installing"
    scoop install fnm
} else {
    scoop update fnm
}

pipx install debugpy
npm install -g @ast-grep/cli

if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
    Write-Host "nvim not installed, installing"
    scoop install neovim-nightly
} else{
    scoop update neovim-nightly
}
