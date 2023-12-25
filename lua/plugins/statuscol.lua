return {
    {
        "luukvbaal/statuscol.nvim",
        branch = "0.10",
        dependencies = {
            "lewis6991/gitsigns.nvim",
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
                                "Diagnostic",
                                "neotest",
                                "Dap",
                            },
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
                            name = { ".*" },
                            namespace = { ".*" },
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
