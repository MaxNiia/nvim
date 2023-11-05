-- Before Lazy
vim.g.mapleader = " "

vim.cmd([[
if has("nvim")
  let $GIT_EDITOR = 'nvim --cmd "let g:unception_block_while_host_edits=1"'
endif

autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
]])

require("utils.config").set_default_config()
require("utils.config").load_config()

local uname = vim.loop.os_uname()

_G.OS = uname.sysname
_G.IS_MAC = OS == "Darwin"
_G.IS_LINUX = OS == "Linux"
_G.IS_WINDOWS = OS:find("Windows") and true or false
_G.IS_WSL = IS_LINUX and uname.release:find("Microsoft") and true or false

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

if _G.neotree then
    require("oil")
end

vim.cmd.colorscheme("catppuccin")
