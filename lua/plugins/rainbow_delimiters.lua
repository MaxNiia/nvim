return {
    {
        "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
        cond = not vim.g.vscode,
        branch = "fix-highlighting",
        config = function(_, _)
            local rainbow = require("rainbow-delimiters")
            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = function(bufnr)
                        -- Disabled for very large files, global strategy for large files,
                        -- local strategy otherwise
                        local line_count = vim.api.nvim_buf_line_count(bufnr)
                        if line_count > 10000 then
                            return nil
                        end
                        return rainbow.strategy["global"]
                    end,
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                    latex = "rainbow-blocks",
                },
                priority = {
                    [""] = 110,
                    lua = 210,
                    latex = 210,
                },
            }
        end,
    },
}
