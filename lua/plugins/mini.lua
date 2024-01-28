-- Dotfile filter
local show_dotfiles = false

return {
    {
        "echasnovski/mini.ai",
        version = false,
        event = "BufEnter",
        config = function(_, opts)
            require("mini.ai").setup(opts)
        end,
    },
    {
        "echasnovski/mini.bracketed",
        version = false,
        event = "BufEnter",
        config = function(_, opts)
            require("mini.bracketed").setup(opts)
        end,
    },
    {
        "echasnovski/mini.comment",
        version = false,
        event = "BufEnter",
        opts = {
            options = {
                custom_commentstring = nil,
                ignore_blank_line = true,
            },
        },
        config = function(_, opts)
            require("mini.comment").setup(opts)
        end,
    },
    {
        "echasnovski/mini.surround",
        version = false,
        event = "BufEnter",
        config = function(_, opts)
            require("mini.surround").setup(opts)
        end,
    },
    {
        "echasnovski/mini.cursorword",
        version = false,
        event = "BufEnter",
        config = function(_, opts)
            require("mini.cursorword").setup(opts)
        end,
    },
    {
        "echasnovski/mini.pairs",
        version = false,
        event = "BufEnter",
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end,
    },
    {
        "echasnovski/mini.files",
        enabled = function()
            return _G.mini_files
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        init = function()
            local filter_show = function(_)
                return true
            end

            local filter_hide = function(fs_entry)
                return not vim.startswith(fs_entry.name, ".")
            end

            local toggle_dotfiles = function()
                show_dotfiles = not show_dotfiles
                local new_filter = show_dotfiles and filter_show or filter_hide
                MiniFiles.refresh({ content = { filter = new_filter } })
            end

            -- Show dotfiles filter toggle.
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf_id = args.data.buf_id
                    vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
                end,
            })

            local map_split = function(buf_id, lhs, direction)
                local rhs = function()
                    -- Make new window and set it as target
                    local new_target_window
                    vim.api.nvim_win_call(MiniFiles.get_target_window() or 0, function()
                        vim.cmd(direction .. " split")
                        new_target_window = vim.api.nvim_get_current_win()
                    end)

                    MiniFiles.set_target_window(new_target_window)
                end

                -- Adding `desc` will result into `show_help` entries
                local desc = "Split " .. direction
                vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
            end

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf_id = args.data.buf_id
                    -- Tweak keys to your liking
                    map_split(buf_id, "gs", "belowright horizontal")
                    map_split(buf_id, "gv", "belowright vertical")
                end,
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesActionRename",
                callback = function(event)
                    local from = event.data.from
                    local to = event.data.to
                    local ret = {} ---@type lsp.Client[]
                    if vim.lsp.get_clients then
                        ret = vim.lsp.get_clients(opts)
                    else
                        ---@diagnostic disable-next-line: deprecated
                        ret = vim.lsp.get_active_clients(opts)
                        if opts and opts.method then
                            ---@param client lsp.Client
                            ret = vim.tbl_filter(function(client)
                                return client.supports_method(opts.method, { bufnr = opts.bufnr })
                            end, ret)
                        end
                    end
                    local clients = opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
                    for _, client in ipairs(clients) do
                        if client.supports_method("workspace/willRenameFiles") then
                            ---@diagnostic disable-next-line: invisible
                            local resp = client.request_sync("workspace/willRenameFiles", {
                                files = {
                                    {
                                        oldUri = vim.uri_from_fname(from),
                                        newUri = vim.uri_from_fname(to),
                                    },
                                },
                            }, 1000, 0)
                            if resp and resp.result ~= nil then
                                vim.lsp.util.apply_workspace_edit(
                                    resp.result,
                                    client.offset_encoding
                                )
                            end
                        end
                    end
                end,
            })
        end,
        version = false,
        event = "BufEnter",
        keys = {
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
        opts = {
            options = {
                permament_delete = true,
                use_as_default_explorer = true,
            },
            windows = {
                preview = true,
                width_preview = 50,
            },
            content = {
                filter = function(fs_entry)
                    if show_dotfiles then
                        return true
                    end
                    return not vim.startswith(fs_entry.name, ".")
                end,
            },
        },
        config = function(_, opts)
            require("mini.files").setup(opts)
        end,
    },
}
