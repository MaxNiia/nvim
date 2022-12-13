local ctp_feline = require("catppuccin.groups.integrations.feline")

ctp_feline.setup({})

require("feline").setup({
   components = ctp_feline.get(),
})

require("feline").winbar.setup({})

vim.api.nvim_create_autocmd("ColorScheme", {
   pattern = "*",
   callback = function()
      package.loaded["feline"] = nil
      package.loaded["catppuccin.groups.integrations.feline"] = nil
      local cat = require("catppuccin.groups.integrations.feline")
      require("feline").setup({
         components = cat.get(),
      })
      require("feline").winbar.setup({})
   end,
})
