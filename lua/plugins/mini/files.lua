-- Filter
local filter_state = false

local filter_none = function(_)
    return true
end

local filter_dotfile = function(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
end

local filter_gitignore = function(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
end

local combined_filter = function(fs_entry)
    if filter_state then
        return filter_none(fs_entry)
    end
    return filter_dotfile(fs_entry) or filter_gitignore(fs_entry)
end

local toggle_filter = function()
    filter_state = not filter_state
    MiniFiles.refresh({ content = { filter = combined_filter } })
end

-- SORT
local sort_state = false

local sort_none = function(entires)
    return require("mini.files").default_sort(entires)
end

local sort_gitignore = function(entries)
    -- technically can filter entries here too, and checking gitignore for _every entry individually_
    -- like I would have to in `content.filter` above is too slow. Here we can give it _all_ the entries
    -- at once, which is much more performant.
    local all_paths = table.concat(
        vim.tbl_map(function(entry)
            return entry.path
        end, entries),
        "\n"
    )
    local output_lines = {}
    local job_id = vim.fn.jobstart({ "git", "check-ignore", "--stdin" }, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            output_lines = data
        end,
    })

    -- command failed to run
    if job_id < 1 then
        return entries
    end

    -- send paths via STDIN
    vim.fn.chansend(job_id, all_paths)
    vim.fn.chanclose(job_id, "stdin")
    vim.fn.jobwait({ job_id })
    return require("mini.files").default_sort(vim.tbl_filter(function(entry)
        return not vim.tbl_contains(output_lines, entry.path)
    end, entries))
end

local combined_sort = function(entries)
    if sort_state then
        return sort_none(entries)
    end
    return sort_gitignore(entries)
end

local toggle_sort = function()
    sort_state = not sort_state
    MiniFiles.refresh({ content = { sort = combined_sort } })
end

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

return {
    "echasnovski/mini.files",
    enabled = function()
        return (not _G.IS_VSCODE) and _G.mini_files,
    end,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesBufferCreate",
            callback = function(args)
                local buf_id = args.data.buf_id
                -- Tweak keys to your liking
                map_split(buf_id, "gs", "belowright horizontal")
                map_split(buf_id, "gv", "belowright vertical")
                vim.keymap.set(
                    "n",
                    "g.",
                    toggle_filter,
                    { buffer = buf_id, desc = "Toggle filter" }
                )
                vim.keymap.set("n", "g,", toggle_sort, { buffer = buf_id, desc = "Toggle sort" })
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesActionRename",
            callback = function(event)
                local from = event.data.from
                local to = event.data.to
                local clients = vim.lsp.get_clients({})
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
                            vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
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
            filter = combined_filter,
            sort = combined_sort,
        },
    },
    config = true,
}
