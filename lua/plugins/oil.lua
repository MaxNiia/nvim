return {
    {
        "stevearc/oil.nvim",
        cond = function()
            return not OPTIONS.mini_files.value and not OPTIONS.yazi.value and not vim.g.vscode
        end,
        init = function()
            if vim.fn.argc() == 1 then
                local arg = vim.fn.argv(0)
                local stat = vim.uv.fs_stat(arg)
                if stat and stat.type == "directory" then
                    vim.cmd.chdir(arg)
                end
            end
        end,
        event = "VimEnter",
        keys = {
            { "g?", desc = "Show Help" },
            { "<CR>", desc = "Select" },
            { "<C-v>", desc = "Vertical split" },
            { "<C-x>", desc = "Horizontal split" },
            { "<C-t>", desc = "New tab" },
            { "<C-p>", desc = "Preview" },
            { "<C-c>", desc = "Close" },
            { "<C-l>", desc = "Refresh" },
            { "-", desc = "Parent" },
            { "_", desc = "CWD" },
            { "`", desc = "cd" },
            { "~", desc = "tcd" },
            { "g.", desc = "Toggle Hidden" },
            {
                "<leader>e",
                function()
                    require("oil").open()
                end,
                desc = "Explorer",
            },
            {
                "<leader>E",
                function()
                    require("oil").open(vim.uv.cwd())
                end,
                desc = "Explorer (CWD)",
            },
        },
        opts = {
            columns = {
                "icon",
            },
            default_file_explorer = true,
            restore_win_options = true,
            skip_confirm_for_simple_edits = false,
            delete_to_trash = false,
            promt_save_on_select_new_entry = true,
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-v>"] = "actions.select_vsplit",
                ["<C-x>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["g."] = "actions.toggle_hidden",
            },
            use_default_keymaps = false,
            view_options = {
                -- Show files and directories that start with "."
                show_hidden = false,
                -- This function defines what is considered a "hidden" file
                is_hidden_file = function(name, _)
                    return vim.startswith(name, ".")
                end,
                -- This function defines what will never be shown, even when `show_hidden` is set
                is_always_hidden = function(_, _)
                    return false
                end,
            },
            -- Configuration for the floating window in oil.open_float
            float = {
                -- Padding around the floating window
                padding = 2,
                max_width = 120,
                max_height = 40,
                border = "rounded",
                win_options = {
                    winblend = 10,
                },
            },
            -- Configuration for the actions floating preview window
            preview = {
                max_width = { 120, 0.9 },
                min_width = { 80, 0.4 },
                max_height = { 60, 0.4 },
                min_height = { 12, 0.1 },
                height = nil,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
            },
            -- Configuration for the floating progress window
            progress = {
                max_width = 0.9,
                min_width = { 40, 0.4 },
                width = nil,
                max_height = { 10, 0.9 },
                min_height = { 5, 0.1 },
                height = nil,
                border = "rounded",
                minimized_border = "none",
                win_options = {
                    winblend = 0,
                },
            },
        },
        config = function(_, opts)
            require("oil").setup(opts)
        end,
    },
}
