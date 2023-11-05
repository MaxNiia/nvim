return function(bufnr)
    local wk = require("plugins.which_key")

    wk.register({
        o = {
            "<cmd>ClangdSwitchSourceHeader<CR>",
            "Switch Header/Source",
        },
    }, {
        prefix = "<leader>",
        buffer = bufnr,
    })
end
