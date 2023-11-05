vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require("user.default.keybindings")
require("user.default.options")
require("user.default.packages")

require("theme.catppuccin.init")
