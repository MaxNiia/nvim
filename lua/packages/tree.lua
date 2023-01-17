require("nvim-tree").setup({
    view = {
        adaptive_size = true,
        relativenumber = true,
        number = true,
        mappings = {
            list = {
                {
                    key = "<C-x>",
                    action = "vsplit",
                },
                {
                    key = "<C-c>",
                    action = "split",
                },
            },
        },
    },
    renderer = {
        symlink_destination = true,
    },
})

local wk = require("which-key")
wk.register({
    ["<leader>"] = {
        e = {
            "<cmd>NvimTreeToggle<CR>",
            "Explorer",
        },
        h = {
            "<cmd>NvimTreeFindFile<CR>",
            "Go to opened file",
        }
    },
}, {})
