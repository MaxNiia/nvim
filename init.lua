-- Before Lazy
vim.g.mapleader = " "

vim.cmd([[
if has('nvim')
  let $GIT_EDITOR = 'nvim --cmd "let g:unception_block_while_host_edits=1"'
endif

autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

]])

require("configs.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {})
require("configs.keybinds")
