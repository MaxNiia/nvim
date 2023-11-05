-- lua

require("project_nvim").setup({
   manual_mode = false,
})

require("nvim-tree").setup({
   sync_root_with_cwd = true,
   respect_buf_cwd = true,
   update_focused_file = {
      enable = true,
      update_root = true,
   },
})
