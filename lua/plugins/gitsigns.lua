return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        enabled = not vim.g.vscode,
        event = "BufEnter",
        opts = {
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 1000,
                ignore_whitespace = true,
            },
            current_line_blame_formatter = "<author>:<author_time:%Y/%m/%d>-<summary>",
            trouble = true,
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local wk = require("which-key")

                -- Navigation
                wk.register({
                    h = {
                        function()
                            if vim.wo.diff then
                                return "]h"
                            end
                            vim.schedule(function()
                                gs.next_hunk()
                            end)
                            return "<Ignore>"
                        end,
                        "Next Hunk",
                    },
                }, { mode = "n", prefix = "]", expr = true })
                wk.register({
                    h = {
                        function()
                            if vim.wo.diff then
                                return "[h"
                            end
                            vim.schedule(function()
                                gs.prev_hunk()
                            end)
                            return "<Ignore>"
                        end,
                        "Prev Hunk",
                    },
                }, { mode = "n", prefix = "[", expr = true })

                local group_key = "g"
                if _G.neotree then
                    group_key = "H"
                end

                -- Actions
                wk.register({
                    s = { gs.stage_hunk, "Stage Hunk" },
                    r = { gs.reset_hunk, "Reset Hunk" },

                    S = { gs.stage_buffer, "Stage Buffer" },
                    u = { gs.undo_stage_hunk, "Undo stage Hunk" },
                    R = { gs.reset_buffer, "Reset Buffer" },
                    p = { gs.preview_hunk, "Preview Hunk" },
                }, { mode = "n", prefix = "<leader>" .. group_key, buffer = bufnr })

                wk.register({
                    s = {
                        function()
                            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                        end,
                        "Stage Hunk",
                    },
                    r = {
                        function()
                            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                        end,
                        "Reset Hunk",
                    },
                }, { mode = "v", prefix = "<leader>" .. group_key, buffer = bufnr })

                -- Text object
                wk.register({
                    h = {
                        ":<C-U>Gitsigns select_hunk<CR>",
                        "Hunk",
                    },
                }, { mode = { "o", "x" }, prefix = "i", buffer = bufnr })
            end,
        },
    },
}
