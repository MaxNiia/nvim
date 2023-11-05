require("persistence").setup
{
    dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
    options = { "buffers", "curdir", "tabpages", "winsize" },
}

local wk = require("which-key")
wk.register({
    q = {
        name = "Persistence",
        s = {
            "<cmd>lua require('persistence').load()<cr>",
            "Restore current directory",
        },
        l = {
            "<cmd>lua require('persistence').load({ last = true })<cr>",
            "Restore last session",
        },
        d = {
            "<cmd>lua require('persistence').stop()<cr>",
            "Don't save",
        },
    },
}, {
    prefix = "<leader>"
})

local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
    group = augroup("disable_session_persistence"),
    pattern = { "gitcommit" },
    callback = function()
        require("persistence").stop()
    end,
})
