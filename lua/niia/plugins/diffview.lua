local icons = require("niia.utils.icons")
return {
    {
        "sindrets/diffview.nvim",
        cond = not vim.g.vscode,
        keys = {
            {
                "<leader>go",
                "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>",
                desc = "Diff to origin",
            },
            {
                "<leader>gd",
                "<cmd>DiffviewOpen<cr>",
                desc = "Open diffview",
            },
            {
                "<leader>gD",
                "<cmd>DiffviewClose<cr>",
                desc = "Close diffview",
            },
        },
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
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
                done = icons.progress.done,
            },
            view = {
                -- diff_view = {
                --     layout = "diff2_horizontal",
                --     winbar_info = true,
                -- },
                merge_tool = {
                    layout = "diff3_mixed",
                    -- winbar_info = true,
                },
            },
            hooks = {
                view_opened = function(
                    _ --[[view]]
                )
                end,
                view_closed = function(
                    _ --[[view]]
                )
                end,
                view_enter = function(
                    _ --[[view]]
                )
                    vim.cmd("UfoDetach")
                    vim.cmd("UfoDisable")
                end,
                view_leave = function(
                    _ --[[view]]
                )
                    vim.cmd("UfoAttach")
                    vim.cmd("UfoEnable")
                end,
            },
        },
    },
}
