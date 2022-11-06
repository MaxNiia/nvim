local packageList = require("user.packageList")

local paq = require("paq") 
paq(packageList)

require("nvim-web-devicons").setup()
require("user.packages.gitsigns")
require("user.packages.lspconfig")
require("user.packages.telescope")
require("user.packages.aerial")
require("user.packages.tree")
require("user.packages.treesitter")
require("user.packages.bufferline")
require("user.packages.catppuccin")
require("user.packages.floaterm")
require("user.packages.indentBlankLine")
