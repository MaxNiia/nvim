local file_functions = require("niia.plugins.mini.files")
return {
    {
        "echasnovski/mini.splitjoin",
        version = false,
        config = true,
    },
    {
        "echasnovski/mini.move",
        version = false,
        event = "VeryLazy",
        opts = {
            mappings = {
                left = "<M-h>",
                right = "<M-l>",
                down = "<M-j>",
                up = "<M-k>",

                line_left = "<M-h>",
                line_right = "<M-l>",
                line_down = "<M-j>",
                line_up = "<M-k>",
            },
        },
        config = true,
    },
    {
        "echasnovski/mini.ai",
        version = false,
        event = "VeryLazy",
        opts = {
            n_lines = 500,
        },
        config = function(_, opts)
            require("mini.ai").setup(opts)
        end,
    },
    {
        "echasnovski/mini.bracketed",
        version = false,
        event = "VeryLazy",
        opts = {
            comment = { suffix = "z" },
        },
        config = true,
    },
    {
        "echasnovski/mini.comment",
        version = false,
        event = "VeryLazy",
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
        event = "VeryLazy",
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
        event = "VeryLazy",
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesWindowOpen",
                callback = function(args)
                    local win_id = args.data.win_id
                    vim.wo[win_id].number = true

                    -- Customize window-local settings
                    local config = vim.api.nvim_win_get_config(win_id)
                    config.border = "rounded"
                    config.title_pos = "center"
                    vim.api.nvim_win_set_config(win_id, config)
                end,
            })
        end,
        config = true,
    },
    {
        "echasnovski/mini.pairs",
        version = false,
        event = "VeryLazy",
        config = true,
    },
    {
        "echasnovski/mini.files",
        version = false,
        event = "VeryLazy",
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
                permanent_delete = true,
                use_as_default_explorer = true,
            },
            windows = {
                preview = true,
                width_preview = 80,
                width_focus = 50,
                width_nofocus = 20,
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
