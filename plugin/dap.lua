vim.fn.sign_define("DapBreakpoint",          { text = "●", texthl = "DapBreakpoint",         linehl = "",              numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "",              numhl = "" })
vim.fn.sign_define("DapLogPoint",            { text = "◆", texthl = "DapLogPoint",            linehl = "",              numhl = "" })
vim.fn.sign_define("DapStopped",             { text = "▶", texthl = "DapStopped",             linehl = "DapStoppedLine", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected",  { text = "●", texthl = "DapBreakpointRejected",  linehl = "",              numhl = "" })

vim.api.nvim_set_hl(0, "DapBreakpoint",         { link = "DiagnosticError" })
vim.api.nvim_set_hl(0, "DapBreakpointCondition",{ link = "DiagnosticWarn"  })
vim.api.nvim_set_hl(0, "DapLogPoint",           { link = "DiagnosticInfo"  })
vim.api.nvim_set_hl(0, "DapStopped",            { link = "DiagnosticWarn"  })
vim.api.nvim_set_hl(0, "DapStoppedLine",        { link = "CursorLine"      })
vim.api.nvim_set_hl(0, "DapBreakpointRejected", { link = "DiagnosticHint"  })

local ok, dap = pcall(require, "dap")
if not ok then return end

local cppdbg_bin = vim.fn.expand("~/.local/share/nvim-lsp/cpptools/extension/debugAdapters/bin/OpenDebugAD7")

dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = cppdbg_bin,
}

local ok_view, dapview = pcall(require, "dap-view")
if ok_view then
    dapview.setup({ auto_toggle = true })
    vim.keymap.set("n", "<leader>dv", "<cmd>DapViewToggle<cr>", { desc = "DAP: Toggle View" })
end

local key = vim.keymap.set
key("n", "<F5>",       dap.continue,          { desc = "DAP: Continue" })
key("n", "<F10>",      dap.step_over,         { desc = "DAP: Step Over" })
key("n", "<F11>",      dap.step_into,         { desc = "DAP: Step Into" })
key("n", "<F12>",      dap.step_out,          { desc = "DAP: Step Out" })
key("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
key("n", "<leader>dc", dap.continue,          { desc = "DAP: Continue" })
key("n", "<leader>dq", dap.terminate,         { desc = "DAP: Terminate" })
key("n", "<leader>dr", dap.repl.open,         { desc = "DAP: REPL" })
