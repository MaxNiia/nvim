return {
    {
        "alexander-born/bazel.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
        config = function()
            local map = vim.keymap.set
            local bazel = require("bazel")
            local my_bazel = require("niia.plugins.bazel.bazel")
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "bzl",
                callback = function()
                    map(
                        "n",
                        "gd",
                        vim.fn.GoToBazelDefinition,
                        { buffer = true, desc = "Goto Definition" }
                    )
                end,
            })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "bzl",
                callback = function()
                    map("n", "<localleader>y", my_bazel.YankLabel, { desc = "Bazel Yank Label" })
                end,
            })
            map("n", "gbt", vim.fn.GoToBazelTarget, { desc = "Goto Bazel Build File" })
            map("n", "<leader>bl", bazel.run_last, { desc = "Bazel Last" })
            map("n", "<leader>bdt", my_bazel.DebugTest, { desc = "Bazel Debug Test" })
            map("n", "<leader>bdr", my_bazel.DebugRun, { desc = "Bazel Debug Run" })
            map("n", "<leader>bt", function()
                bazel.run_here("test", vim.g.bazel_config)
            end, { desc = "Bazel Test" })
            map("n", "<leader>bb", function()
                bazel.run_here("build", vim.g.bazel_config)
            end, { desc = "Bazel Build" })
            map("n", "<leader>br", function()
                bazel.run_here("run", vim.g.bazel_config)
            end, { desc = "Bazel Run" })
            map("n", "<leader>bdb", function()
                bazel.run_here("build", vim.g.bazel_config .. " --compilation_mode dbg --copt=-O0")
            end, { desc = "Bazel Debug Build" })
            map(
                "n",
                "<leader>bda",
                my_bazel.set_debug_args_from_input,
                { desc = "Set Bazel Debug Arguments" }
            )
        end,
    },
}
