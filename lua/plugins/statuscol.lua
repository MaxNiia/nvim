return {
    {
        "luukvbaal/statuscol.nvim",
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
                                "neotest",
                                "Dap",
                            },
                            maxwidth = 1,
                            colwidth = 2,
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
                            name = {
                                "GitSigns",
                            },
                            maxwidth = 2,
                            colwidth = 1,
                            auto = false,
                        },
                        click = "v:lua.ScSa",
                    },
                },
                clickhandlers = {
                    -- builtin click handlers
                    Lnum = builtin.lnum_click,
                    FoldClose = builtin.foldclose_click,
                    FoldOpen = builtin.foldopen_click,
                    FoldOther = builtin.foldother_click,
                    DapBreakpointRejected = builtin.toggle_breakpoint,
                    DapBreakpoint = builtin.toggle_breakpoint,
                    DapBreakpointCondition = builtin.toggle_breakpoint,
                    DiagnosticSignError = builtin.diagnostic_click,
                    DiagnosticSignHint = builtin.diagnostic_click,
                    DiagnosticSignInfo = builtin.diagnostic_click,
                    DiagnosticSignWarn = builtin.diagnostic_click,
                    GitSignsTopdelete = builtin.gitsigns_click,
                    GitSignsUntracked = builtin.gitsigns_click,
                    GitSignsAdd = builtin.gitsigns_click,
                    GitSignsChange = builtin.gitsigns_click,
                    GitSignsChangedelete = builtin.gitsigns_click,
                    GitSignsDelete = builtin.gitsigns_click,
                },
            })
        end,
    },
}
