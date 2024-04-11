return {
    {
        "kazhala/close-buffers.nvim",
        cond = not vim.g.vscode,
        dependencies = {
            "folke/which-key.nvim",
        },
        event = "BufEnter",
        opts = {
            filetype_ignore = require("utils.exclude_files"),
            preserve_window_layout = {
                "this",
                "nameless",
            },
        },
        config = function(_, opts)
            require("close_buffers").setup(opts)

            local wk = require("which-key")
            wk.register({
                q = {
                    function()
                        require("close_buffers").delete({ type = "this" })
                    end,
                    "Delete current buffer",
                },
                Q = {
                    function()
                        require("close_buffers").delete({ type = "other" })
                    end,
                    "Delete other buffers",
                },
            }, { mode = "n", prefix = "<leader>" })
        end,
    },
}
