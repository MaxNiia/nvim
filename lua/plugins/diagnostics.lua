return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        opts = {
            multiple_diag_under_cursor = true,
            signs = {
                left = "",
                right = "",
                diag = "●",
                arrow = "    ",
                up_arrow = "    ",
                vertical = " │",
                vertical_end = " └",
            },
            virt_texts = { priority = 2048 },
        },
        config = function(_, opts)
            require("tiny-inline-diagnostic").setup(opts)
            vim.api.nvim_set_hl(
                0,
                "TinyInlineDiagnosticVirtualTextError",
                { link = "DiagnosticVirtualTextError" }
            )
            vim.api.nvim_set_hl(
                0,
                "TinyInlineDiagnosticVirtualTextWarn",
                { link = "DiagnosticVirtualTextWarn" }
            )
            vim.api.nvim_set_hl(
                0,
                "TinyInlineDiagnosticVirtualTextInfo",
                { link = "DiagnosticVirtualTextInfo" }
            )
            vim.api.nvim_set_hl(
                0,
                "TinyInlineDiagnosticVirtualTextHint",
                { link = "DiagnosticVirtualTextHint" }
            )
            vim.api.nvim_set_hl(
                0,
                "TinyInlineDiagnosticVirtualTextHint",
                { link = "DiagnosticVirtualTextHint" }
            )
            vim.api.nvim_set_hl(0, "TinyInlineInvDiagnosticVirtualTextError", {
                fg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextError" })["bg"],
                bg = vim.api.nvim_get_hl(0, { name = "CursorLine" })["bg"],
            })
            vim.api.nvim_set_hl(0, "TinyInlineInvDiagnosticVirtualTextWarn", {
                fg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextWarn" })["bg"],
                bg = vim.api.nvim_get_hl(0, { name = "CursorLine" })["bg"],
            })
            vim.api.nvim_set_hl(0, "TinyInlineInvDiagnosticVirtualTextInfo", {
                fg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextInfo" })["bg"],
                bg = vim.api.nvim_get_hl(0, { name = "CursorLine" })["bg"],
            })
            vim.api.nvim_set_hl(0, "TinyInlineInvDiagnosticVirtualTextHint", {
                fg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextHint" })["bg"],
                bg = vim.api.nvim_get_hl(0, { name = "CursorLine" })["bg"],
            })
        end,
    },
}
