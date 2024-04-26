return {
    {
        "serenevoid/kiwi.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {},
        keys = {
            {
                "<leader>T",
                ':lua require("kiwi").todo.toggle()<cr>',
                desc = "Toggle Markdown Task",
            },
        },

        config = function(_, opts)
            for name, _ in pairs(OPTIONS.wikis.value) do
                table.insert(opts, {
                    name = name,
                    path = vim.fn.expand(OPTIONS.wiki.value) .. "/" .. name,
                })
            end

            local wk = require("which-key")
            for name, value in pairs(OPTIONS.wikis.value) do
                wk.register({
                    [value.key] = {
                        '<cmd>lua require("kiwi").open("' .. name .. '")<cr>',
                        "Open " .. name .. " wiki",
                    },
                }, { prefix = "<leader>w", mode = "n" })
            end

            require("kiwi").setup(opts)
        end,
        lazy = true,
    },
}
