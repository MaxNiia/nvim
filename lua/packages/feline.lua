local ctp_feline = require("catppuccin.groups.integrations.feline")

local clrs = require("catppuccin.palettes").get_palette()

ctp_feline.setup({})

require("feline").setup({
   components = ctp_feline.get(),
})

local comp_winbar = {
   active = {},
   inactive = {},
}

table.insert(comp_winbar.inactive, {})
table.insert(comp_winbar.active, {})

-- Name
table.insert(comp_winbar.inactive[1], {
   provider = {
      name = "file_info",
      opts = {
         type = "base-only",
      },
   },
   hl = {
      fg = clrs.mauve,
      bg = clrs.surface0,
   },
})

-- Filepath
table.insert(comp_winbar.active[1], {
   provider = {
      name = "file_info",
      opts = {
         type = "relative",
      },
   },
   short_provied = {
      name = "file_info",
      opts = {
         type = "base-only",
      },
   },
   hl = {
      fg = clrs.blue,
      bg = clrs.surface1,
   },
})

require("feline").winbar.setup({
   components = comp_winbar,
})

vim.api.nvim_create_autocmd("ColorScheme", {
   pattern = "*",
   callback = function()
      package.loaded["feline"] = nil
      package.loaded["catppuccin.groups.integrations.feline"] = nil
      local cat = require("catppuccin.groups.integrations.feline")
      require("feline").setup({
         components = cat.get(),
      })
      require("feline").winbar.setup({
         components = comp_winbar,
      })
   end,
})
