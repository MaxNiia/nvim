require("dashboard").setup({
   config = {
      week_header = {
         enable = true,
      },
      shortcut = {
         {
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
         },
         {
            desc = "Projects",
            group = "Label",
            action = "Telescope projects",
            key = "p",
         },
      },
   },
})
