return {
    {
        "mrjones2014/smart-splits.nvim",
        cond = not vim.g.vscode,
        dependencies = {
            "kwkarlwang/bufresize.nvim",
        },
        lazy = true,
        event = "VimEnter",
        opts = {
            ignored_filetypes = {
                "nofile",
                "quickfix",
                "prompt",
            },
            resize_mode = {
                silent = true,
                hooks = {
                    on_enter = function()
                        vim.notify("Entering resize mode")
                    end,
                    on_leave = function()
                        vim.notify("Exiting resize mode, bye")
                        return require("bufresize").register
                    end,
                },
            },
            at_edge = "wrap",
        },
        config = function(_, opts)
            require("smart-splits").setup(opts)

            -- moving between splits
            vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
            vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
            vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
            vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
            --
            -- resizing splits
            -- these keymaps will also accept a range,
            -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
            vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
            vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
            vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
            vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
            vim.keymap.set("n", "<C-w><C-h>", require("smart-splits").resize_left)
            vim.keymap.set("n", "<C-w><C-j>", require("smart-splits").resize_down)
            vim.keymap.set("n", "<C-w><C-k>", require("smart-splits").resize_up)
            vim.keymap.set("n", "<C-w><C-l>", require("smart-splits").resize_right)

            -- swapping buffers between windows
            vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
            vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
            vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
            vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
        end,
    },
}
