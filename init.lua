-- Before Lazy
vim.g.mapleader = " "

vim.cmd([[
if has("nvim")
  let $GIT_EDITOR = 'nvim --cmd "let g:unception_block_while_host_edits=1"'
endif

autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
]])

_G.mini_files = true
_G.neotree = false
_G.toggleterm = true
_G.oled = false
_G.copilot = false
_G.popup = true
_G.harpoon = true
_G.buffer_mode = false
_G.lsp_lines = true
_G.prompt_end = "%$ ",

require("utils.config").load_config()

local uname = vim.loop.os_uname()

_G.OS = uname.sysname
_G.IS_MAC = OS == "Darwin"
_G.IS_LINUX = OS == "Linux"
_G.IS_WINDOWS = OS:find("Windows") and true or false
_G.IS_WSL = IS_LINUX and uname.release:find("Microsoft") and true or false

if vim.g.neovide then
    require("configs.neovide")
elseif  vim.g.vscode then
    require("configs.vscode")
end

require("configs.options")
require("configs.autocmd")
require("configs.commands")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {})

vim.cmd.colorscheme("catppuccin")
