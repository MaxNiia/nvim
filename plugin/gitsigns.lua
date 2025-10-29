require("gitsigns").setup({
    signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
    },
    status_formatter = function(status)
        local added, changed, removed = status.added, status.changed, status.removed
        local status_txt = {}
        if added and added > 0 then
            table.insert(status_txt, "" .. added)
        end
        if changed and changed > 0 then
            table.insert(status_txt, "" .. changed)
        end
        if removed and removed > 0 then
            table.insert(status_txt, "" .. removed)
        end
        return table.concat(status_txt, " ")
    end,
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
    word_diff = false,
    watch_gitdir = {
        follow_files = true,
    },
    current_line_blame = true,
    diff_opts = {
        ignore_blank_lines = true,
    },
    current_line_blame_opts = {
        virt_text = false,
        virt_text_pos = "eol",
        delay = 500,
        virt_text_priority = 100,
        ignore_whitespace = true,
    },
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    max_file_length = 5000,
    attach_to_untracked = true,
    trouble = true,
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local key = vim.keymap.set

        -- Navigation
        key({ "n", "v" }, "]h", function()
            if vim.wo.diff then
                return "]h"
            end
            vim.schedule(function()
                gs.nav_hunk("next", { wrap = true })
            end)
            return "<Ignore>"
        end, {
            buffer = bufnr,
            expr = true,
            replace_keycodes = false,
            desc = "Next Hunk",
        })
        key({ "n", "v" }, "[h", function()
            if vim.wo.diff then
                return "[h"
            end
            vim.schedule(function()
                gs.nav_hunk("prev", { wrap = true })
            end)
            return "<Ignore>"
        end, {
            buffer = bufnr,
            expr = true,
            replace_keycodes = false,
            desc = "Prev Hunk",
        })
        key({ "n", "v" }, "]H", function()
            if vim.wo.diff then
                return "]H"
            end
            vim.schedule(function()
                gs.nav_hunk("last")
            end)
            return "<Ignore>"
        end, {
            buffer = bufnr,
            expr = true,
            replace_keycodes = false,
            desc = "Last Hunk",
        })
        key({ "n", "v" }, "[H", function()
            if vim.wo.diff then
                return "[H"
            end
            vim.schedule(function()
                gs.nav_hunk("first")
            end)
            return "<Ignore>"
        end, {
            buffer = bufnr,
            expr = true,
            replace_keycodes = false,
            desc = "First Hunk",
        })
        key("n", "<leader>gq", gs.setqflist, {
            buffer = bufnr,
            desc = "List buffer hunks",
        })
        key("n", "<leader>gQ", function()
            gs.setqflist("all")
        end, {
            buffer = bufnr,
            desc = "List all hunks",
        })
        key("n", "<leader>gs", gs.stage_hunk, {
            buffer = bufnr,
            desc = "Stage Hunk",
        })
        key("n", "<leader>gR", gs.reset_buffer, {
            buffer = bufnr,
            desc = "Reset Buffer",
        })
        key("n", "<leader>gr", gs.reset_hunk, {
            buffer = bufnr,
            desc = "Reset Hunk",
        })
        key("n", "<leader>gS", gs.stage_buffer, {
            buffer = bufnr,
            desc = "Stage Buffer",
        })
        key("n", "<leader>gp", gs.preview_hunk_inline, {
            buffer = bufnr,
            desc = "Preview Hunk Inline",
        })
        key("n", "<leader>gP", gs.preview_hunk, {
            buffer = bufnr,
            desc = "Preview Hunk",
        })
        key("v", "<leader>gs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, {
            buffer = bufnr,
            desc = "Stage Hunk",
        })
        key("v", "<leader>gr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, {
            buffer = bufnr,
            desc = "Reset Hunk",
        })
        key({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", {
            buffer = bufnr,
            desc = "Hunk",
        })
        key({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>", {
            buffer = bufnr,
            desc = "Hunk",
        })
    end,
})
