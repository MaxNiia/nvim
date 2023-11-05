require("aerial").setup({
    on_attach = function(bufnr)
        local wk = require("which-key")
        wk.register({
            A = {
                ["["] = {
                    "<cmd>AerialPrev<CR>",
                    "Previous Aerial",
                },
                ["]"] = {
                    "<cmd>AerialNext<CR>",
                    "Next Aerial",
                },
            },
        }, {
            prefix = "<leader>",
            buffer = bufnr,
        })
    end,
})

local wk = require("which-key")
wk.register({
    A = {
        "<cmd>AerialToggle!<CR>",
        "Toggle Aerial",
    },
}, {
    prefix = "<leader>",
})
