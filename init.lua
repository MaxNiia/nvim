require('impatient')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true


require("init")

if vim.env.NVIM_EPIROC then
	require("epiroc.init")
else
	require("user.init")
end
