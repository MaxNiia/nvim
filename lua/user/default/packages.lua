local packageList = require("packageList")

local paq = require("paq")
paq(packageList)

require("nvim-web-devicons").setup()
require("packages.gitsigns")
require("packages.mason")
require("packages.cmp")
require("packages.lspconfig")
require("packages.trouble")
require("packages.telescope")
require("packages.aerial")
require("packages.autopairs")
require("packages.todo")
require("packages.tree")
require("packages.treesitter")
require("packages.markdown_preview")
require("packages.project")
require("packages.floaterm")
require("packages.indentBlankLine")
require("packages.feline")
require("packages.noice_config")
require("packages.telekasten")
require("packages.persisted")
require("packages.dashboard")
-- require("packages.dap")

require("leap").add_default_mappings()