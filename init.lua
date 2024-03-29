-- Before Lazy
vim.g.mapleader = " "

vim.cmd([[
if has("nvim")
  let $GIT_EDITOR = 'nvim --cmd "let g:unception_block_while_host_edits=1"'
endif

autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
]])

OPTIONS = {
    mini_files = {
        value = true,
        key = "m",
        description = "mini.files",
        prompt = nil,
    },
    neotree = {
        value = false,
        key = "n",
        description = "Neotree",
        prompt = nil,
    },
    toggleterm = {
        value = false,
        key = "t",
        description = "Toggleterm",
        prompt = nil,
    },
    chatgpt = {
        value = false,
        key = "C",
        description = "ChatGPT",
        prompt = nil,

    },
    oled = {
        value = false,
        key = "o",
        description = "OLED Catppuccin",
        prompt = nil,
    },
    copilot = {
        value = false,
        key = "c",
        description = "Copilot",
        prompt = nil,
    },
    popup = {
        value = true,
        key = "p",
        description = "Command line popup",
        prompt = nil,
    },
    harpoon = {
        value = false,
        key = "h",
        description = "Harpoon",
        prompt = nil,
    },
    buffer_mode = {
        value = false,
        key = "b",
        description = "Buffer mode",
        prompt = nil,
    },
    lsp_lines = {
        value = false,
        key = "l",
        description = "lsp_lines",
        prompt = nil,
    },
    prompt_end = {
        value = "%$ ",
        key = "P",
        description = "Terminal prompt",
        prompt = "Enter your terminal prompt",
    },
    font_size = {
        value = 11.0,
        key = "f",
        description = "Font size",
        prompt = "Enter desired font size",
    },
}

require("utils.config").load_config()

local uname = vim.loop.os_uname()

_G.OS = uname.sysname
_G.IS_MAC = OS == "Darwin"
_G.IS_LINUX = OS == "Linux"
_G.IS_WINDOWS = OS:find("Windows") and true or false
_G.IS_WSL = IS_LINUX and uname.release:find("Microsoft") and true or false

if vim.g.neovide then
    require("configs.neovide")
elseif vim.g.vscode then
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
