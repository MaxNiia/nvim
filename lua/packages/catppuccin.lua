vim.g.catppuccin_flavour = "frappe"
local colors = require("catppuccin.palettes").get_palette()
colors.none = "NONE"

require("catppuccin").setup({
   flavour = "frappe",
   compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
   transparent_background = false,
   term_colors = true,
   dim_inactive = {
      enabled = true,
      percentage = 0.50,
   },

   integrations = {
      aerial = true,
      beacon = true,
      cmp = true,
      dashboard = true,
      gitsigns = true,
      -- feline = true,
      fidget = true,
      indent_blankline = {
         enabled = true,
         colored_indent_levels = true,
      },
      leap = true,
      mason = true,
      nvimtree = true,
      telescope = true,
      ts_rainbow = true,
      treesitter = true,
      treesitter_context = true,
      native_lsp = {
         enabled = true,
      },
      noice = true,
      notify = true,
      which_key = true,
   },
})

vim.api.nvim_command("colorscheme catppuccin")
