return {
    {
        "nvim-neotest/neotest",
        cond = not vim.g.vscode,
        dependencies = {
            "alfaix/neotest-gtest",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/nvim-nio",
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = true,
        event = "VeryLazy",
        keys = {
            {
                "<leader>tr",
                function()
                    require("neotest").run.run(vim.fn.expand("%"))
                end,
                mode = "n",
                desc = "Run current file tests",
            },
            {
                "<leader>tR",
                function()
                    require("neotest").run.run()
                end,
                mode = "n",
                desc = "Run nearest test",
            },
            {
                "<leader>td",
                function()
                    require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
                end,
                mode = "n",
                desc = "Debug current file tests",
            },
            {
                "<leader>tD",
                function()
                    require("neotest").run.run({ strategy = "dap" })
                end,
                mode = "n",
                desc = "Debug nearest test",
            },
            {
                "<leader>ts",
                function()
                    require("neotest").run.stop()
                end,
                mode = "n",
                desc = "Stop test",
            },
            {
                "<leader>ta",
                function()
                    require("neotest").run.attach()
                end,
                mode = "n",
                desc = "Attach to test",
            },
        },
        config = function(_, opts)
            opts = vim.tbl_extend("force", {
                adapters = {
                    require("neotest-gtest").setup({
                        debug_adapter = "gdb",
                        is_test_file = function(file)
                            return vim.startswith(file("test"))
                                or vim.startswith(file("test_"))
                                or vim.startswith(file("Test"))
                                or vim.startswith(file("Test_"))
                                or vim.endswith(file("Test"))
                                or vim.endswith(file("_Test"))
                                or vim.endswith(file("test"))
                                or vim.endswith(file("_test"))
                        end,
                    }),
                },
            }, opts or {})
            require("neotest").setup(opts)
        end,
    },
}
