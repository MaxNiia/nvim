local function eval()
    return require("dapui").eval()
end
local function toggle()
    return require("dapui").toggle()
end
local function hover()
    return require("dap.ui.widgets").hover()
end
return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        keys = require("plugins.dap.keymap"),
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "ofirgall/goto-breakpoints.nvim",
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/cmp-dap",
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-dap-ui",
            "jay-babu/mason-nvim-dap.nvim",
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
            local dap = require("dap")
            local api = vim.api
            local keymap_restore = {}
            dap.listeners.after["event_initialized"]["me"] = function()
                for _, buf in pairs(api.nvim_list_bufs()) do
                    local keymaps = api.nvim_buf_get_keymap(buf, "n")
                    for _, keymap in pairs(keymaps) do
                        if keymap.lhs == "K" then
                            table.insert(keymap_restore, keymap)
                            api.nvim_buf_del_keymap(buf, "n", "K")
                        end
                    end
                end
                api.nvim_set_keymap(
                    "n",
                    "K",
                    '<Cmd>lua require("dap.ui.widgets").hover()<CR>',
                    { silent = true }
                )
            end

            dap.listeners.after["event_terminated"]["me"] = function()
                for _, keymap in pairs(keymap_restore) do
                    api.nvim_buf_set_keymap(
                        keymap.buffer,
                        keymap.mode,
                        keymap.lhs,
                        keymap.rhs,
                        { silent = keymap.silent == 1 }
                    )
                end
                keymap_restore = {}
            end

            require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        dependencies = {
            "mortepau/codicons.nvim",
            "mfussenegger/nvim-dap",
        },
        keys = {
            { "<leader>bt", toggle, mode = "n", desc = "Toggle UI" },
            { "<leader>bh", hover, mode = "n", desc = "Hover" },
            { "<leader>be", eval, mode = { "n", "x" }, desc = "Evaluate expression" },
        },
        config = function(_, opts)
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup(opts)
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
}
