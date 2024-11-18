return {
    {
        "ThePrimeagen/refactoring.nvim",
        keys = {
            {
                "<leader>re",
                ":Refactor extract ",
                desc = "Extract",
                mode = "x",
            },
            {
                "<leader>rf",
                ":Refactor extract_to_file ",
                desc = "Extract to file",
                mode = "x",
            },
            {
                "<leader>rv",
                ":Refactor extract_var ",
                desc = "Extract var",
                mode = "x",
            },
            {
                "<leader>rI",
                ":Refactor inline_func",
                desc = "Inline function",
                mode = "n",
            },
            {
                "<leader>rb",
                ":Refactor extract_block",
                desc = "Extract block",
                mode = "n",
            },
            {
                "<leader>rB",
                ":Refactor extract_block_to_file",
                desc = "Extract block to file",
                mode = "n",
            },
            {
                "<leader>ri",
                ":Refactor inline_var",
                desc = "Inline variable",
                mode = { "n", "x" },
            },
            {
                "<leader>rpp",
                function()
                    require("refactoring").debug.printf({ below = false })
                end,
                desc = "Print",
                mode = "n",
            },
            {
                "<leader>rpV",
                function()
                    require("refactoring").debug.print_var({})
                end,
                desc = "Print variable",
                mode = { "x", "n" },
            },

            {
                "<leader>rpc",
                function()
                    require("refactoring").debug.cleanup({})
                end,
                desc = "Cleanup prints",
                mode = "n",
            },
        },
        opts = {
            printf_statements = {
                cpp = vim.g.cpp_print_statements.default,
            },
            print_var_statements = {
                cpp = vim.g.cpp_print_statements.variable,
            },
            extract_var_statements = {
                cpp = "%s{%s};",
            },
            prompt_func_return_type = {
                go = true,
                cpp = true,
                c = true,
                java = true,
            },
            -- prompt for function parameters
            prompt_func_param_type = {
                go = true,
                cpp = true,
                c = true,
                java = true,
            },
        },
        config = function(_, opts)
            require("refactoring").setup(opts)
        end,
    },
}
