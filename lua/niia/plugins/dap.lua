return {
    {
        "mfussenegger/nvim-dap",
        keys = {
            {
                "<f1>",
                function()
                    require("dap").continue()
                end,
                desc = "Continue",
                mode = { "n" },
            },
            {
                "<f2>",
                function()
                    require("dap").step_into()
                end,
                desc = "Step into",
                mode = { "n" },
            },
            {
                "<f3>",
                function()
                    require("dap").step_over()
                end,
                desc = "Step over",
                mode = { "n" },
            },
            {
                "<f4>",
                function()
                    require("dap").step_out()
                end,
                desc = "Step out",
                mode = { "n" },
            },
            {
                "<f5>",
                function()
                    require("dap").step_back()
                end,
                desc = "Step out",
                mode = { "n" },
            },
            {
                "<leader>b",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "Breakpoint",
                mode = { "n" },
            },
            {
                "<leader>B",
                function()
                    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point Message: "))
                end,
                desc = "Logpoint",
                mode = { "n" },
            },
            {
                "<leader>Dr",
                function()
                    require("dap").repl.open()
                end,
                desc = "Open repl",
                mode = "n",
            },
            {
                "<leader>Dl",
                function()
                    require("dap").run_last()
                end,
                desc = "Run last",
                mode = "n",
            },
            {
                "<leader>Dh",
                function()
                    require("dap.ui.widgets").hover()
                end,
                desc = "Hover",
                mode = { "n", "v" },
            },
            {
                "<leader>Dp",
                function()
                    require("dap.ui.widgets").preview()
                end,
                desc = "Preview",
                mode = { "n", "v" },
            },
            {
                "<leader>Df",
                function()
                    local widgets = require("dap.ui.widgets")
                    widgets.centered_float(widgets.frames)
                end,
                desc = "Frames",
                mode = "n",
            },
            {
                "<leader>Ds",
                function()
                    local widgets = require("dap.ui.widgets")
                    widgets.centered_float(widgets.scopes)
                end,
                desc = "Scopes",
                mode = "n",
            },
            {
                "<leader>Dt",
                function()
                    require("dapui").toggle()
                end,
                desc = "Toggle UI",
                mode = "n",
            },
            {
                "<leader>DL",
                function()
                    require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })
                end,
                desc = "Load launch.json",
                mode = { "n" },
            },
        },
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "ofirgall/goto-breakpoints.nvim",
            "theHamsta/nvim-dap-virtual-text",
            -- "rcarriga/cmp-dap",
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
        config = function(_, opts)
            local icons = require("niia.utils.icons")
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

            require("nvim-dap-virtual-text").setup(opts)
            local map = vim.keymap.set
            map("n", "]b", require("goto-breakpoints").next, {})
            map("n", "[b", require("goto-breakpoints").prev, {})
            map("n", "]S", require("goto-breakpoints").stopped, {})

            -- require("cmp").setup({
            --     enabled = function()
            --         return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
            --             or require("cmp_dap").is_dap_buffer()
            --     end,
            -- })

            -- require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
            --     sources = {
            --         { name = "dap" },
            --     },
            -- })

            require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        keys = {
            {
                "<leader>Dt",
                function()
                    return require("dapui").toggle()
                end,
                mode = "n",
                desc = "Toggle UI",
            },
            {
                "<leader>Dh",
                function()
                    require("dap.ui.widgets").hover()
                end,
                mode = "n",
                desc = "Hover",
            },
            {
                "<leader>De",
                function()
                    require("dapui").eval()
                end,
                mode = { "n", "x" },
                desc = "Evaluate expression",
            },
        },
        config = function(_, opts)
            local dap, dapui = require("dap"), require("dapui")

            dap.adapters.godot = { type = "server", host = "127.0.0.1", port = 6006 }
            dap.configurations.gdscript = {
                {
                    type = "godot",
                    request = "launch",
                    name = "Launch scene",
                    project = "${workspaceFolder}",
                    launch_scene = true,
                },
            }

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
