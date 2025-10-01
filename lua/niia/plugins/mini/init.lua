local file_functions = require("niia.plugins.mini.files")
return {
    {
        "nvim-mini/mini.nvim",
        version = false,
        lazy = false,
        keys = (vim.g.vscode or (vim.g.yazi and vim.g.browsers)) and {} or {
            {
                "<leader>e",
                "<cmd>lua MiniFiles.open(MiniFiles.get_latest_path())<cr>",
                desc = "Files",
                mode = "n",
            },
            {
                "<leader>EC",
                "<cmd>lua MiniFiles.open(nil, false)<cr>",
                desc = "CWD",
                mode = "n",
            },
            {
                "<leader>EB",
                "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<cr>",
                desc = "Buffer Dir",
                mode = "n",
            },
            {
                "<leader>EH",
                "<cmd>lua MiniFiles.open(vim.fn.expand('$HOME'))<cr>",
                desc = "Home",
                mode = "n",
            },
        },
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesWindowOpen",
                callback = function(args)
                    local win_id = args.data.win_id
                    vim.wo[win_id].number = false

                    -- Customize window-local settings
                    local config = vim.api.nvim_win_get_config(win_id)
                    config.border = "rounded"
                    config.title_pos = "center"
                    vim.api.nvim_win_set_config(win_id, config)
                end,
            })
        end,
        config = function()
            local gen_loader = require("mini.snippets").gen_loader
            local snippets = {
                gen_loader.from_file("~/.config/nvim/snippets/global.json"),
                gen_loader.from_lang(),
            }

            if vim.g.extra_snippets ~= nil then
                snippets = vim.tbl_deep_extend("force", snippets, vim.g.extra_snippets(gen_loader))
            end

            require("mini.snippets").setup({
                snippets = snippets,
                mappings = {
                    expand = "",
                    jump_next = "",
                    jump_prev = "",
                    stop = "",
                },
            })

            local make_stop = function()
                local au_opts = { pattern = "*:n", once = true }
                au_opts.callback = function()
                    while MiniSnippets.session.get() do
                        MiniSnippets.session.stop()
                    end
                end
                vim.api.nvim_create_autocmd("ModeChanged", au_opts)
            end
            local opts = { pattern = "MiniSnippetsSessionStart", callback = make_stop }
            vim.api.nvim_create_autocmd("User", opts)

            require("mini.move").setup()
            require("mini.splitjoin").setup()
            require("mini.icons").setup({
                file = {
                    [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
                    ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
                },
                filetype = {
                    dotenv = { glyph = "", hl = "MiniIconsYellow" },
                },
            })
            require("mini.ai").setup({
                n_lines = 500,
            })
            require("mini.bracketed").setup({
                comment = {
                    suffix = "z",
                },
            })
            require("mini.comment").setup({
                options = {
                    custom_commentstring = nil,
                    ignore_blank_line = true,
                },
            })
            require("mini.surround").setup({
                custom_surroundings = {
                    ["("] = {
                        input = { "%b()", "^.().*().$" },
                        output = { left = "(", right = ")" },
                    },
                    ["["] = {
                        input = { "%b[]", "^.().*().$" },
                        output = { left = "[", right = "]" },
                    },
                    ["{"] = {
                        input = { "%b{}", "^.().*().$" },
                        output = { left = "{", right = "}" },
                    },
                    ["<"] = {
                        input = { "%b<>", "^.().*().$" },
                        output = { left = "<", right = ">" },
                    },
                },
            })
            require("mini.cursorword").setup()
            require("mini.align").setup()
            require("mini.move").setup()
            require("mini.pairs").setup()
            if not (vim.g.vscode or (vim.g.yazi and vim.g.browser)) then
                require("mini.files").setup({
                    options = {
                        permanent_delete = true,
                        use_as_default_explorer = true,
                    },
                    windows = {
                        preview = true,
                        width_preview = 80,
                        width_focus = 50,
                        width_nofocus = 20,
                    },
                    content = {
                        filter = file_functions.filter,
                        sort = file_functions.sort,
                    },
                    -- mappings = {
                    --     go_in = "l",
                    --     go_in_plus = "L",
                    --     go_out = "h",
                    --     go_out_plus = "H",
                    -- }
                })
            end
        end,
        file_functions.init(),
    },
}
