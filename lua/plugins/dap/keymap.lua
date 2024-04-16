return {
    {
        "<f5>",
        function()
            require("dap").continue()
        end,
        desc = "Continue",
        mode = { "n" },
    },
    {
        "<f10>",
        function()
            require("dap").step_over()
        end,
        desc = "Step over",
        mode = { "n" },
    },
    {
        "<f11>",
        function()
            require("dap").step_into()
        end,
        desc = "Step into",
        mode = { "n" },
    },
    {
        "<f12>",
        function()
            require("dap").step_out()
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
}
