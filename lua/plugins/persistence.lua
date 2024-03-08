return {
    {
        "folke/persistence.nvim",
        enabled = not _G.IS_VSCODE,
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {
            dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
            options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
            pre_save = nil, -- a function to call before saving the session
            save_empty = false, -- don't save if there are no open file buffers
        },
    },
}
