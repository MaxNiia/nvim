local packageList = require("packageList")

local paq = require("paq")
paq(packageList)

require("nvim-web-devicons").setup()
require("packages.gitsigns")
require("packages.mason")
require("packages.null")
require("packages.lspconfig")
require("packages.trouble")
require("packages.telescope")
require("packages.aerial")
require("packages.tree")
require("packages.treesitter")
--require("packages.bufferline")
require("packages.floaterm")
require("packages.indentBlankLine")
require("packages.feline")
-- require("common.packages.dap")

require("leap").add_default_mappings()

require("packages.catppuccin")
