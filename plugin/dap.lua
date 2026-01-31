local dap = require("dap")
local dapui = require("dapui")

local icons = require("icons")

vim.fn.sign_define("DapBreakpoint", { text = icons.dap.Breakpoint[1], texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = icons.dap.BreakpointCondition, texthl = "DiagnosticWarning" })
vim.fn.sign_define("DapBreakpointRejected", { text = icons.dap.BreakpointRejected[1], texthl = "DiagnosticError" })
vim.fn.sign_define("DapStopped", { text = icons.dap.Stopped[1], texthl = "DiagnosticInfo" })

dapui.setup({
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.25 },
                { id = "breakpoints", size = 0.25 },
                { id = "stacks", size = 0.25 },
                { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                { id = "repl", size = 0.5 },
                { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
        },
    },
})

require("nvim-dap-virtual-text").setup({
    enabled = true,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = false,
    show_stop_reason = true,
    commented = false,
})

-- Auto-open/close UI
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "gdb",
    args = { "-i", "dap" },
}

local codelldb_path = vim.fn.expand("~/opt/codelldb/adapter/codelldb")
local liblldb_path = vim.fn.expand("~/opt/codelldb/lldb/lib/liblldb.so") -- macOS: liblldb.dylib
dap.adapters.lldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = codelldb_path,
        args = { "--port", "${port}" },
        -- If needed:
        -- detached = false,
    },
}

-- Default C/C++ configuration (can be overridden in .exrc)
dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
    },
    {
        name = "Attach to process",
        type = "cppdbg",
        request = "attach",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        processId = function()
            return tonumber(vim.fn.input("Process ID: "))
        end,
    },
}
dap.configurations.c = dap.configurations.cpp

-- Rust adapter
dap.configurations.rust = {
    {
        name = "Debug current crate",
        type = "lldb",
        request = "launch",
        program = function()
            -- ask for target/debug binary, defaulting to crate name
            return vim.fn.input(
                "Executable: ",
                vim.fn.getcwd() .. "/target/debug/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
                "file"
            )
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
        env = function()
            return { LLDB_LAUNCH_FLAG_LAUNCH_ON_ATTACH = "1" }
        end,
    },
}

-- Python adapter
dap.adapters.python = {
    type = "executable",
    command = "python3",
    args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            return "python3"
        end,
    },
    {
        type = "python",
        request = "attach",
        name = "Attach remote",
        connect = function()
            local host = vim.fn.input("Host [localhost]: ")
            host = host ~= "" and host or "localhost"
            local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
            return { host = host, port = port }
        end,
    },
}

-- Keybinds
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Conditional Breakpoint" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
vim.keymap.set("n", "<leader>dh", function()
    require("dap.ui.widgets").hover()
end, { desc = "Debug: Hover" })
vim.keymap.set("n", "<leader>dp", function()
    require("dap.ui.widgets").preview()
end, { desc = "Debug: Preview" })
vim.keymap.set("n", "<leader>df", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.frames)
end, { desc = "Debug: Frames" })
vim.keymap.set("n", "<leader>ds", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.scopes)
end, { desc = "Debug: Scopes" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })
