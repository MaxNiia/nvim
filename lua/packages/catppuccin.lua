vim.g.catppuccin_flavour = "macchiato"
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
      --	bufferline = true,
      cmp = true,
      gitsigns = true,
      -- feline = true,
      fidget = true,
      indent_blankline = {
         enabled = true,
         colored_indent_levels = true,
      },
      leap = true,
      ts_rainbow = true,
      treesitter_context = true,
      nvimtree = true,
      telescope = true,
      treesitter = true,
      native_lsp = {
         enabled = true,
      },
      which_key = true,
   },
})

vim.api.nvim_command("colorscheme catppuccin")
