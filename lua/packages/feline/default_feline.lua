require("feline").setup({
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
})

require("feline").winbar.setup({
   components = comp_winbar,
})

vim.api.nvim_create_autocmd("ColorScheme", {
   pattern = "*",
   callback = function()
      package.loaded["feline"] = nil
      require("feline").setup({
      })
      require("feline").winbar.setup({
         components = comp_winbar,
      })
   end,
})
