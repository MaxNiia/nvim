local call_dap = function(func)
    return require("dap")[func]
end

local call_breakpoints = function(func)
    return require("goto-breakpoints")[func]
end

return {
    {

        "<leader>bc",
        "<cmd>DapContinue<cr>",
        desc = "Continue",
        mode = { "n" },
    },
    {
        "<leader>bs",
        "<cmd>DapStepOver<cr>",
        desc = "Step Over",
        mode = { "n" },
    },
    {
        "<leader>bi",
        "<cmd>DapStepInto<cr>",
        desc = "Step Into",
        mode = { "n" },
    },
    {
        "<leader>bo",
        "<cmd>DapStepOut<cr>",
        mode = { "n" },
    },
    {
        "<leader>bb",
        "<cmd>DapToggleBreakpoint<cr>",
        desc = "Breakpoint",
        mode = { "n" },
    },
    {
        "<leader>bR",
        "<cmd>DapToggleRepl<cr>",
        desc = "Open repl",
        mode = { "n" },
    },
    {
        "<leader>bl",
        desc = "Run last session",
        mode = { "n" },
    },
    {
        "<leader>br",
        "<cmd>DapRestartFrame<cr>",
        desc = "Restart session",
        mode = { "n" },
    },
    {
        "<leader>bq",
        "<cmd>DapTerminate<cr>",
        desc = "Terminate session",
        mode = { "n" },
    },
}
