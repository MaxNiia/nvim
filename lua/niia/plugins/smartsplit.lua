return {
    {
        "mrjones2014/smart-splits.nvim",
        dependencies = {
            "kwkarlwang/bufresize.nvim",
        },
        lazy = false,
        opts = {
            resize_mode = {
                silent = true,
                hooks = {
                    on_enter = function()
                        vim.notify("Entering resize mode")
                    end,
                    on_leave = function()
                        vim.notify("Exiting resize mode, bye")
                        return require("bufresize").register
                    end,
                },
            },
            default_amount = 5,
            at_edge = "wrap",
        },
        keys = {
            {
                "<C-h>",
                function()
                    require("smart-splits").move_cursor_left()
                end,
                desc = "Move cursor left",
                mode = "n",
            },
            {
                "<C-j>",
                function()
                    require("smart-splits").move_cursor_down()
                end,
                desc = "Move cursor down",
                mode = "n",
            },
            {
                "<C-k>",
                function()
                    require("smart-splits").move_cursor_up()
                end,
                desc = "Move cursor up",
                mode = "n",
            },
            {
                "<C-l>",
                function()
                    require("smart-splits").move_cursor_right()
                end,
                desc = "Move cursor right",
                mode = "n",
            },
            {
                "<C-\\>",
                function()
                    require("smart-splits").move_cursor_previous()
                end,
                desc = "Move cursor previous",
                mode = "n",
            },
            {
                "<A-h>",
                function()
                    require("smart-splits").resize_left()
                end,
                desc = "Resize left",
                mode = "n",
            },
            {
                "<A-j>",
                function()
                    require("smart-splits").resize_down()
                end,
                desc = "Resize down",
                mode = "n",
            },
            {
                "<A-k>",
                function()
                    require("smart-splits").resize_up()
                end,
                desc = "Resize up",
                mode = "n",
            },
            {
                "<A-l>",
                function()
                    require("smart-splits").resize_right()
                end,
                desc = "Resize right",
                mode = "n",
            },

            {
                "<leader><leader>h",
                function()
                    require("smart-splits").swap_buf_left()
                end,
                desc = "Swap left",
                mode = "n",
            },
            {
                "<leader><leader>j",
                function()
                    require("smart-splits").swap_buf_down()
                end,
                desc = "Swap down",
                mode = "n",
            },
            {
                "<leader><leader>k",
                function()
                    require("smart-splits").swap_buf_up()
                end,
                desc = "Swap up",
                mode = "n",
            },
            {
                "<leader><leader>l",
                function()
                    require("smart-splits").swap_buf_right()
                end,
                desc = "Swap right",
                mode = "n",
            },
        },
        config = function(_, opts)
            require("smart-splits").setup(opts)
        end,
    },
}
