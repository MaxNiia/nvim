local utils = require("plugins.telescope.utils")
local call_telescope = utils.call_telescope

local keymaps = {
    {
        "<leader>fp",
        ":lua require'telescope'.extensions.project.project{display_type = 'full'}<cr>",
        desc = "Project",
        mode = { "v", "n" },
    },
    {
        "<leader>fm",
        function()
            require("telescope").extensions.monorepo.monorepo()
        end,
        desc = "Monorepo",
        mode = { "v", "n" },
    },
    {
        "<leader>wm",
        function()
            require("telescope").extensions.monorepo.monorepo()
        end,
        desc = "Monorepo",
        mode = { "v", "n" },
    },
    {
        "<leader>fM1",
        call_telescope("man_pages", {
            sections = { "1" },
        }),
        desc = "Executables/Shell Commands",
        mode = { "v", "n" },
    },
    {
        "<leader>fM2",
        call_telescope("man_pages", {
            sections = { "2" },
        }),
        desc = "System calls",
        mode = { "v", "n" },
    },
    {
        "<leader>fM3",
        call_telescope("man_pages", {
            sections = { "3" },
        }),
        desc = "Library calls",
        mode = { "v", "n" },
    },
    {
        "<leader>fM4",
        call_telescope("man_pages", {
            sections = { "4" },
        }),
        desc = "Special files",
        mode = { "v", "n" },
    },
    {
        "<leader>fM5",
        call_telescope("man_pages", {
            sections = { "5" },
        }),
        desc = "File formats and conventions",
        mode = { "v", "n" },
    },
    {
        "<leader>fM6",
        call_telescope("man_pages", {
            sections = { "6" },
        }),
        desc = "Games",
        mode = { "v", "n" },
    },
    {
        "<leader>fM7",
        call_telescope("man_pages", {
            sections = { "7" },
        }),
        desc = "Misc",
        mode = { "v", "n" },
    },
    {
        "<leader>fM8",
        call_telescope("man_pages", {
            sections = { "8" },
        }),
        desc = "System admin",
        mode = { "v", "n" },
    },
    {
        "<leader>fM9",
        call_telescope("man_pages", {
            sections = { "9" },
        }),
        desc = "Kernel routines (non standard)",
        mode = { "v", "n" },
    },
    { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo history", mode = { "v", "n" } },
    { "<leader>fN", "<cmd>Telescope noice<cr>", desc = "Noice", mode = { "v", "n" } },
    { "<leader>fn", "<cmd>Telescope notify<cr>", desc = "Noice", mode = { "v", "n" } },
    {
        "<leader>fc",
        "<cmd>Telescope themes<cr>",
        desc = "Colorscheme",
    },
}

return keymaps
