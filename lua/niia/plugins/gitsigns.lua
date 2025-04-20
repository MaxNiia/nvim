return {

    {
        "lewis6991/gitsigns.nvim",
        event = "BufEnter",
        cond = not vim.g.vscode,
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            preview_config = {
                style = "minimal",
                relative = "cursor",
            },
            signs_staged = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
            },
            signcolumn = true,
            numhl = true,
            linehl = false,
            word_diff = true,
            watch_gitdir = {
                follow_files = true,
            },
            current_line_blame = true,
            diff_opts = {
                ignore_blank_lines = true,
            },
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 500,
                virt_text_priority = 100,
                ignore_whitespace = true,
            },
            current_line_blame_formatter = "<author> <author_time:%Y %m %d> <summary>",
            max_file_length = 5000,
            attach_to_untracked = true,
            trouble = true,
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local wk = require("which-key")

                -- Navigation
                wk.add({
                    {
                        "]h",
                        function()
                            if vim.wo.diff then
                                return "]h"
                            end
                            vim.schedule(function()
                                gs.nav_hunk("next", { wrap = true })
                            end)
                            return "<Ignore>"
                        end,
                        buffer = bufnr,
                        mode = { "n", "v" },
                        expr = true,
                        replace_keycodes = false,
                        desc = "Next Hunk",
                    },
                    {
                        "[h",
                        function()
                            if vim.wo.diff then
                                return "[h"
                            end
                            vim.schedule(function()
                                gs.nav_hunk("prev", { wrap = true })
                            end)
                            return "<Ignore>"
                        end,
                        buffer = bufnr,
                        mode = { "n", "v" },
                        expr = true,
                        replace_keycodes = false,
                        desc = "Prev Hunk",
                    },
                    {
                        "]H",
                        function()
                            if vim.wo.diff then
                                return "]H"
                            end
                            vim.schedule(function()
                                gs.nav_hunk("last")
                            end)
                            return "<Ignore>"
                        end,
                        buffer = bufnr,
                        mode = { "n", "v" },
                        expr = true,
                        replace_keycodes = false,
                        desc = "Last Hunk",
                    },
                    {
                        "[H",
                        function()
                            if vim.wo.diff then
                                return "[H"
                            end
                            vim.schedule(function()
                                gs.nav_hunk("first")
                            end)
                            return "<Ignore>"
                        end,
                        buffer = bufnr,
                        mode = { "n", "v" },
                        expr = true,
                        replace_keycodes = false,
                        desc = "First Hunk",
                    },
                    {
                        "<leader>gq",
                        gs.setqflist,
                        mode = "n",
                        buffer = bufnr,
                        desc = "List buffer hunks",
                    },
                    {
                        "<leader>gQ",
                        function()
                            gs.setqflist("all")
                        end,
                        mode = "n",
                        buffer = bufnr,
                        desc = "List all hunks",
                    },
                    {
                        "<leader>gs",
                        gs.stage_hunk,
                        mode = "n",
                        buffer = bufnr,
                        desc = "Stage Hunk",
                    },
                    {
                        "<leader>gR",
                        gs.reset_buffer,
                        mode = "n",
                        buffer = bufnr,
                        desc = "Reset Buffer",
                    },
                    {
                        "<leader>gr",
                        gs.reset_hunk,
                        mode = "n",
                        buffer = bufnr,
                        desc = "Reset Hunk",
                    },
                    {
                        "<leader>gS",
                        gs.stage_buffer,
                        mode = "n",
                        buffer = bufnr,
                        desc = "Stage Buffer",
                    },
                    {
                        "<leader>gp",
                        gs.preview_hunk_inline,
                        mode = "n",
                        buffer = bufnr,
                        desc = "Preview Hunk Inline",
                    },
                    {
                        "<leader>gP",
                        gs.preview_hunk,
                        mode = "n",
                        buffer = bufnr,
                        desc = "Preview Hunk",
                    },
                    {
                        "<leader>gs",
                        function()
                            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                        end,
                        mode = "v",
                        buffer = bufnr,
                        desc = "Stage Hunk",
                    },
                    {
                        "<leader>gr",
                        function()
                            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                        end,
                        mode = "v",
                        buffer = bufnr,
                        desc = "Reset Hunk",
                    },
                    {
                        "ih",
                        ":<C-U>Gitsigns select_hunk<CR>",
                        mode = { "o", "x" },
                        buffer = bufnr,
                        desc = "Hunk",
                    },
                    {
                        "ah",
                        ":<C-U>Gitsigns select_hunk<CR>",
                        mode = { "o", "x" },
                        buffer = bufnr,
                        desc = "Hunk",
                    },
                })
            end,
        },
    },
}
