return {
    {
        "chrisgrieser/nvim-early-retirement",
        cond = OPTIONS.early_retirement.value,
        event = "VeryLazy",
        opts = {
            ignoredFiletypes = require("utils.exclude_files"),
            retirementAgeMins = 20,
            notificationOnAutoClose = true,
        },
    },
    -- {
    --     "kazhala/close-buffers.nvim",
    --     cond = not vim.g.vscode,
    --     keys = {

    --         {
    --             "<leader>q",
    --             function()
    --                 require("close_buffers").delete({ type = "this" })
    --             end,
    --             mode = "n",
    --             desc = "Delete current buffer",
    --         },
    --         {
    --             "<leader>Q",
    --             function()
    --                 require("close_buffers").delete({ type = "other" })
    --             end,
    --             mode = "n",
    --             desc = "Delete other buffers",
    --         },
    --     },
    --     event = "BufEnter",
    --     opts = {
    --         filetype_ignore = require("utils.exclude_files"),
    --         preserve_window_layout = {
    --             "this",
    --             "nameless",
    --         },
    --     },
    -- },
}
