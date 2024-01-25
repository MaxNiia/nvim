local icons = require("utils.icons")
return {
    {
        "sindrets/diffview.nvim",
        opts = {
            diff_binaries = false,
            enhanced_diff_hl = true,
            use_icons = true,
            icons = {
                folder_closed = icons.folder_closed,
                folder_open = icons.folder_open,
            },
            signs = {
                fold_closed = icons.fold.closed,
                fold_open = icons.fold.open,
                done = "✓",
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
                end,
            },
        },
    },
}
