local file_functions = require("plugins.mini.files")
return {
    {
        "echasnovski/mini.ai",
        version = false,
        event = "BufEnter",
        config = true,
    },
    {
        "echasnovski/mini.bracketed",
        version = false,
        event = "BufEnter",
        config = true,
    },
    {
        "echasnovski/mini.comment",
        version = false,
        event = "BufEnter",
        opts = {
            options = {
                custom_commentstring = nil,
                ignore_blank_line = true,
            },
        },
        config = true,
    },
    {
        "echasnovski/mini.surround",
        version = false,
        event = "BufEnter",
        opts = {
            custom_surroundings = {
                ["("] = { input = { "%b()", "^.().*().$" }, output = { left = "(", right = ")" } },
                ["["] = { input = { "%b[]", "^.().*().$" }, output = { left = "[", right = "]" } },
                ["{"] = { input = { "%b{}", "^.().*().$" }, output = { left = "{", right = "}" } },
                ["<"] = { input = { "%b<>", "^.().*().$" }, output = { left = "<", right = ">" } },
            },
        },
        config = true,
    },
    {
        "echasnovski/mini.cursorword",
        version = false,
        event = "BufEnter",
        config = true,
    },
    {
        "echasnovski/mini.pairs",
        version = false,
        event = "BufEnter",
        config = true,
    },
    {
        "echasnovski/mini.files",
        cond = (not vim.g.vscode) and OPTIONS.mini_files.value,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        version = false,
        event = "BufEnter",
        keys = {
            {
                "<leader>e",
                "<cmd>lua MiniFiles.open(MiniFiles.get_latest_path())<cr>",
                desc = "Files",
                mode = "n",
            },
            {
                "<leader>EC",
                "<cmd>lua MiniFiles.open(nil, false)<cr>",
                desc = "CWD",
                mode = "n",
            },
            {
                "<leader>EB",
                "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<cr>",
                desc = "Buffer Dir",
                mode = "n",
            },
            {
                "<leader>EH",
                "<cmd>lua MiniFiles.open(vim.fn.expand('$HOME'))<cr>",
                desc = "Home",
                mode = "n",
            },
        },
        init = file_functions.init,
        opts = {
            options = {
                permament_delete = true,
                use_as_default_explorer = true,
            },
            windows = {
                preview = true,
                width_preview = 50,
            },
            content = {
                filter = file_functions.filter,
                sort = file_functions.sort,
            },
            -- mappings = {
            --     go_in = "l",
            --     go_in_plus = "L",
            --     go_out = "h",
            --     go_out_plus = "H",
            -- }
        },
    },
}
