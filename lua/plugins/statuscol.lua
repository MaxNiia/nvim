return {
    {
        "chentoast/marks.nvim",
        lazy = true,
        opts = {
            default_mappings = true,
            builtin_marks = {},
            cyclic = true,
            force_write_shada = true,
            refresh_interval = 150,
            sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        },
    },
    {
        "luukvbaal/statuscol.nvim",
        branch = "0.10",
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "chentoast/marks.nvim",
        },
        lazy = true,
        event = "BufEnter",
        init = function()
            vim.o.fillchars = "foldopen:,foldclose:,foldsep:┃"
        end,
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
                    "help",
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
                            auto = true,
                        },
                        click = "v:lua.ScFa",
                    },
                    {
                        sign = {
                            name = {
                                "Mark",
                                "neotest",
                                "Dap",
                            },
                            namespace = { "diagnostic*" },
                            maxwidth = 2,
                            colwidth = 1,
                            auto = true,
                        },
                        click = "v:lua.ScSa",
                    },
                    {
                        text = {
                            builtin.lnumfunc,
                        },
                        click = "v:lua.ScLa",
                    },
                    {
                        sign = {
                            namespace = { "gitsigns" },
                            maxwidth = 2,
                            colwidth = 1,
                            wrap = true,
                            auto = true,
                        },
                        click = "v:lua.ScSa",
                    },
                    { text = { "│" }, condition = { builtin.not_empty } },
                },
            })
        end,
    },
}
