return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        keys = require("plugins.dap.keymap"),
        dependencies = {
            "ofirgall/goto-breakpoints.nvim",
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/cmp-dap",
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-dap-ui",
        },
        opts = {
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = true,
            all_references = false,
            show_stop_reason = true,
            commented = false,
            virt_text_pos = "inline",
            only_first_definition = true,
        },
        init = function()
            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Error" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "לּ", texthl = "Error" })
            vim.fn.sign_define("DapLogPoint", { text = "", texthl = "Directory" })
            vim.fn.sign_define("DapStopped", { text = "ﰲ", texthl = "TSConstant" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "Error" })
        end,
        config = function(_, opts)
            require("nvim-dap-virtual-text").setup(opts)
            local map = vim.keymap.set
            map("n", "]b", require("goto-breakpoints").next, {})
            map("n", "[b", require("goto-breakpoints").prev, {})
            map("n", "]S", require("goto-breakpoints").stopped, {})

            require("cmp").setup({
                enabled = function()
                    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
                        or require("cmp_dap").is_dap_buffer()
                end,
            })

            require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
                sources = {
                    { name = "dap" },
                },
            })
        end,
    },
}
