return {
    {
        "chentoast/marks.nvim",
        lazy = true,
        opts = {
            default_mappings = true,
            cyclic = true,
            force_write_shada = true,
            refresh_interval = 150,
            sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        },
    },
    {
        "luukvbaal/statuscol.nvim",
        cond = not vim.g.vscode,
        lazy = true,
        event = "BufEnter",
        config = function(_, _)
            local builtin = require("statuscol.builtin")

            require("statuscol").setup({
                relculright = true,
                thousands = "'",
                ft_ignore = {
                    "Outline",
                    "terminal",
                    "toggleterm",
                    "qf",
                    "Trouble",
                },
                bt_ignore = {
                    "Outline",
                    "terminal",
                    "help",
                    "nofile",
                    "toggleterm",
                    "qf",
                    "Trouble",
                },

                segments = {
                    {
                        text = {
                            builtin.foldfunc,
                        },
                        hl = "FoldColumn",
                        click = "v:lua.ScFa",
                    },
                    {
                        sign = {
                            name = {
                                "Mark",
                                "neotest",
                                "Dap",
                                -- "todo*",
                            },
                            -- namespace = { "diagnostic*" },
                            maxwidth = 5,
                            colwidth = 1,
                            auto = true,
                            foldclosed = true,
                        },
                    },
                    -- {
                    --     sign = {
                    --         namespace = { "gitsigns" },
                    --         maxwidth = 2,
                    --         colwidth = 1,
                    --         wrap = true,
                    --         auto = true,
                    --     },
                    --     click = "v:lua.ScSa",
                    -- },
                    {
                        text = {
                            builtin.lnumfunc,
                            "│",
                        },
                    },
                },
            })
        end,
    },
}
