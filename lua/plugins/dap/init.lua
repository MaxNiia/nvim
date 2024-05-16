local function eval()
    return require("dapui").eval()
end

local function toggle()
    return require("dapui").toggle()
end

local function hover()
    return require("dap.ui.widgets").hover()
end

local api = vim.api
local keymap_restore = {}

return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        cond = not vim.g.vscode,
        keys = require("plugins.dap.keymap"),
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "ofirgall/goto-breakpoints.nvim",
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/cmp-dap",
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-dap-ui",
            "jay-babu/mason-nvim-dap.nvim",

            "nvim-telescope/telescope-dap.nvim",
            "nvim-telescope/telescope.nvim",
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
        config = function(_, opts)
            local icons = require("utils.icons")
            vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

            for name, sign in pairs(icons.dap) do
                sign = type(sign) == "table" and sign or { sign }
                vim.fn.sign_define("Dap" .. name, {
                    text = sign[1],
                    texthl = sign[2] or "DiagnosticInfo",
                    linehl = sign[3],
                    numhl = sign[3],
                })
            end

            if not OPTIONS.fzf.value then
                require("telescope").load_extension("dap")
            end

            require("nvim-dap-virtual-text").setup(opts)
            local map = vim.keymap.set
            map("n", "]b", require("goto-breakpoints").next, {})
            map("n", "[b", require("goto-breakpoints").prev, {})
            map("n", "]S", require("goto-breakpoints").stopped, {})

            require("cmp").setup({
                enabled = function()
                    return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
                        or require("cmp_dap").is_dap_buffer()
                end,
            })

            require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
                sources = {
                    { name = "dap" },
                },
            })

            -- local dap = require("dap")
            -- dap.listeners.after["event_initialized"]["me"] = function()
            --     for _, buf in pairs(api.nvim_list_bufs()) do
            --         local keymaps = api.nvim_buf_get_keymap(buf, "n")
            --         for _, keymap in pairs(keymaps) do
            --             if keymap.lhs == "K" then
            --                 table.insert(keymap_restore, keymap)
            --                 api.nvim_buf_del_keymap(buf, "n", "K")
            --             end
            --         end
            --     end
            --     api.nvim_set_keymap(
            --         "n",
            --         "K",
            --         '<Cmd>lua require("dap.ui.widgets").hover()<CR>',
            --         { silent = true }
            --     )
            -- end

            -- dap.listeners.after["event_terminated"]["me"] = function()
            --     for _, keymap in pairs(keymap_restore) do
            --         api.nvim_buf_set_keymap(
            --             keymap.buffer,
            --             keymap.mode,
            --             keymap.lhs,
            --             keymap.rhs,
            --             { silent = keymap.silent == 1 }
            --         )
            --     end
            --     keymap_restore = {}
            -- end

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
            { "<leader>Dt", toggle, mode = "n", desc = "Toggle UI" },
            { "<leader>Dh", hover, mode = "n", desc = "Hover" },
            { "<leader>De", eval, mode = { "n", "x" }, desc = "Evaluate expression" },
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
