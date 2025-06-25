local icons = require("niia.utils.icons")
local review_diff = function()
    local options = { "main", "master", "dev", "Other..." }

    vim.ui.select(options, {
        prompt = "Select base branch for PR diff:",
        format_item = function(item)
            return item == "Other..." and "Enter custom branch..." or "Compare with " .. item
        end,
    }, function(choice)
        if not choice then
            print("Cancelled PR diffview")
            return
        end

        if choice == "Other..." then
            vim.ui.input({ prompt = "Enter custom base branch: " }, function(input)
                if input and input ~= "" then
                    vim.cmd("DiffviewOpen origin/" .. input .. "...HEAD")
                else
                    print("Cancelled custom branch input")
                end
            end)
        else
            vim.cmd("DiffviewOpen origin/" .. choice .. "...HEAD")
        end
    end)
end

vim.api.nvim_create_user_command("Review", review_diff, {})
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
            {
                "<leader>gh",
                review_diff,
                desc = "Open review",
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
            file_panel = {
                win_config = function()
                    local c = { type = "split", position = "left" }
                    local editor_width = vim.o.columns
                    c.width = math.min(80, editor_width)
                    return c
                end,
            },
            commit_log_panel = {
                win_config = function()
                    local c = { type = "split", position = "right" }
                    local editor_width = vim.o.columns
                    c.width = math.min(80, editor_width)
                    return c
                end,
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
                end,
                view_leave = function(
                    _ --[[view]]
                )
                end,
            },
        },
    },
}
