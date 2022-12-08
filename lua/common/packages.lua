local packageList = require("common.packageList")

local paq = require("paq") 
paq(packageList)

require("nvim-web-devicons").setup()
require("common.packages.gitsigns")
require("common.packages.lspconfig")
require("common.packages.trouble")
require("common.packages.telescope")
require("common.packages.aerial")
require("common.packages.tree")
require("common.packages.treesitter")
--require("common.packages.bufferline")
require("common.packages.floaterm")
require("common.packages.indentBlankLine")
require("common.packages.feline")
-- require("common.packages.dap")

require("leap").add_default_mappings()

require("common.packages.catppuccin")
