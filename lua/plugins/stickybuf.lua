return {
    {
        "stevearc/stickybuf.nvim",
        enabled = not _G.IS_VSCODE,
        config = function(_, _)
            require("stickybuf").setup({
                get_auto_pin = function(bufnr)
                    local should_pin = require("stickybuf").should_auto_pin(bufnr)
                    if should_pin == nil then
                        local filetype = vim.bo[bufnr].filetype
                        if filetype == "minifiles" then
                            should_pin = "buftype"
                        end
                    end
                    return should_pin
                end,
            })
        end,
    },
}
