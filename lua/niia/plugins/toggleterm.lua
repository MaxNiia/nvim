return {
    {
        "akinsho/toggleterm.nvim",
        keys = {
            {
                "<f6>",
                function()
                    local term_number = vim.v.count
                    return "<cmd>" .. tostring(term_number) .. "ToggleTerm direction=vertical<cr>"
                end,
                desc = "Toggle vertical",
                mode = { "n", "t" },
                expr = true,
            },
            {
                "<f7>",
                function()
                    local term_number = vim.v.count
                    return "<cmd>" .. tostring(term_number) .. "ToggleTerm direction=horizontal<cr>"
                end,
                desc = "Toggle vertical",
                mode = { "n", "t" },
                expr = true,
            },
            {
                "<f8>",
                function()
                    local term_number = vim.v.count
                    return "<cmd>" .. tostring(term_number) .. "ToggleTerm direction=float<cr>"
                end,
                desc = "Toggle float",
                mode = { "n", "t" },
                expr = true,
            },
        },
        opts = {
            size = function(term)
                if term.direction == "horizontal" then
                    local integral, _ = math.modf(math.min(vim.o.lines * 0.33, 40))
                    return integral
                elseif term.direction == "vertical" then
                    local integral, _ = math.modf(math.min(vim.o.columns * 0.50, 100))
                    return integral
                end
                return 0
            end,
            on_create = function(terminal)
                terminal.name = terminal.count
            end,
            open_mapping = "<f8>",
            hide_number = true,
            autochdir = false,
            shade_terminals = false,
            start_in_insert = true,
            terminal_mappings = true,
            -- persist_size = true,
            persist_mode = true,
            direction = "vertical", --| "horizontal" | "tab" | "float",
            close_on_exit = false,
            shell = vim.o.shell,
            auto_scroll = true,
            float_opts = {
                border = "curved",
                width = function()
                    local integral, _ = math.modf(math.min(vim.o.columns * 0.50, 100))
                    return integral
                end,
                height = function()
                    local integral, _ = math.modf(math.min(vim.o.lines * 0.33, 60))
                    return integral
                end,
                winblend = 0,
            },
            winbar = {
                enabled = false,
                name_formatter = function(term) --  term: Terminal
                    return term.name
                end,
            },
        },
    },
}