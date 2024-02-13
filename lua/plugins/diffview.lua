local icons = require("utils.icons")
local group_key = "g"
if _G.neotree then
    group_key = "H"
end

return {
    {
        "sindrets/diffview.nvim",
        keys = {
            {
                "<leader>" .. group_key .. "o",
                "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>",
                desc = "Diff to origin",
            },
            {
                "<leader>" .. group_key .. "f",
                "<cmd>DiffviewFileHistory<cr>",
                desc = "View file history",
            },
            {
                "<leader>" .. group_key .. "c",
                "<cmd>DiffviewClose<cr>",
                desc = "Close diffview",
            },
            {
                "<leader>" .. group_key .. "d",
                "<cmd>DiffviewOpen<cr>",
                desc = "Open diffview",
            },
            {
                "<leader>" .. group_key .. "c",
                "<cmd>DiffviewClose<cr>",
                desc = "Close diffview",
            },
        },
        opts = {
            diff_binaries = false,
            enhanced_diff_hl = true,
            use_icons = true,
            keymaps = {
                file_panel = {
                    {
                        "n",
                        "cc",
                        "<Cmd>Git commit <bar> wincmd J<CR>",
                        { desc = "Commit staged changes" },
                    },
                    {
                        "n",
                        "ca",
                        "<Cmd>Git commit --amend <bar> wincmd J<CR>",
                        { desc = "Amend the last commit" },
                    },
                    {
                        "n",
                        "c<space>",
                        ":Git commit ",
                        { desc = 'Populate command line with ":Git commit "' },
                    },
                },
            },
            icons = {
                folder_closed = icons.folder_closed,
                folder_open = icons.folder_open,
            },
            signs = {
                fold_closed = icons.fold.closed,
                fold_open = icons.fold.open,
                done = icons.misc.done,
            },
            view = {
                merge_tool = {
                    layout = "diff3_mixed",
                },
            },
            hooks = {
                view_opened = function(
                    _ --[[view]]
                )
                    vim.cmd("UfoDetach")
                    vim.cmd("UfoDisable")
                    vim.cmd("ColorizerDetachFromBuffer")
                end,
                view_closed = function(
                    _ --[[view]]
                )
                    vim.cmd("UfoAttach")
                    vim.cmd("UfoEnable")
                    vim.cmd("ColorizerReloadAllBuffers")
                end,
                view_enter = function(
                    _ --[[view]]
                )
                    vim.cmd("UfoDetach")
                    vim.cmd("UfoDisable")
                    vim.cmd("ColorizerDetachFromBuffer")
                end,
                view_leave = function(
                    _ --[[view]]
                )
                    vim.cmd("UfoAttach")
                    vim.cmd("UfoEnable")
                    vim.cmd("ColorizerReloadAllBuffers")
                end,
            },
        },
    },
}
