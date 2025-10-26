local function statusline()
    local parts_left  = {}
    local parts_mid   = {}
    local parts_right = {}
    -- ====================================================== LEFT =======================================================
    local mode_map    = {
        n       = "N",
        no      = "N·OP",
        i       = "I",
        v       = "V",
        V       = "V-L",
        ["\22"] = "V-B", -- CTRL-V block mode
        c       = "C",
        R       = "R",
        s       = "S",
        S       = "S-L",
        ["\19"] = "S-B",
        t       = "T",
    }
    local mode_hl_map = {
        n       = "MiniStatuslineModeNormal",
        i       = "MiniStatuslineModeInsert",
        v       = "MiniStatuslineModeVisual",
        V       = "MiniStatuslineModeVisual",
        ["\22"] = "MiniStatuslineModeVisual",
        c       = "MiniStatuslineModeCommand",
        R       = "MiniStatuslineModeReplace",
        t       = "MiniStatuslineModeOther",
    }

    local m           = vim.api.nvim_get_mode().mode
    local mode_label  = mode_map[m] or m
    local mode_hl     = mode_hl_map[m] or "StatusLine"

    table.insert(parts_left, 1, ("%#" .. mode_hl .. "# " .. mode_label .. " %#StatusLine#"))
    --
    local gs = vim.b.gitsigns_status_dict
    do
        local filename = "%#DiagnosticError#" .. "%<%f" .. "%#StatusLine#" -- relative file path
        local flags = {}

        -- Help / preview indicators (%h, %w)
        if vim.bo.buftype == "help" then
            table.insert(flags, "[help]")
        end
        if vim.wo.previewwindow then
            table.insert(flags, "[preview]")
        end

        -- Modified indicator: use  instead of '+'
        if vim.bo.modified then
            table.insert(flags, "")
        end

        -- Readonly indicator (%r)
        if vim.bo.readonly then
            table.insert(flags, "")
        end

        table.insert(parts_left, filename .. " " .. table.concat(flags, " "))
    end

    do
        local ok, devicons = pcall(require, "nvim-web-devicons")
        if ok then
            local filename = vim.fn.expand("%:t")
            local ext = vim.fn.expand("%:e")
            local icon, icon_hl = devicons.get_icon(filename, ext, { default = true })

            if icon then
                -- add highlight if available
                if icon_hl then
                    table.insert(parts_left, "%#" .. icon_hl .. "#" .. icon .. "%#StatusLine#")
                else
                    table.insert(parts_left, icon)
                end
            end
        end
    end

    if vim.o.showcmdloc == "statusline" then
        table.insert(parts_left, "%-10.S ")
    end

    do
        if gs then
            local git_parts = {}

            if gs.added and gs.added > 0 then
                table.insert(git_parts, "%#GitSignsAdd#" .. gs.added .. "%#StatusLine#")
            end
            if gs.changed and gs.changed > 0 then
                table.insert(git_parts, "%#GitSignsChange#" .. gs.changed .. "%#StatusLine#")
            end
            if gs.removed and gs.removed > 0 then
                table.insert(git_parts, "%#GitSignsDelete#" .. gs.removed .. "%#StatusLine#")
            end

            if #git_parts > 0 then
                table.insert(parts_left, table.concat(git_parts, " "))
            end
        end
    end

    do
        local function count_diagnostics(severity)
            local diags = vim.diagnostic.get(0, { severity = severity })
            return #diags
        end

        local num_errors          = count_diagnostics(vim.diagnostic.severity.ERROR)
        local num_warns           = count_diagnostics(vim.diagnostic.severity.WARN)
        local num_infos           = count_diagnostics(vim.diagnostic.severity.INFO)
        local num_hints           = count_diagnostics(vim.diagnostic.severity.HINT)
        local ok_icons, icons_mod = pcall(require, "icons")
        local items               = {}

        if ok_icons then
            local diagnostics = icons_mod.diagnostics
            if num_errors > 0 then
                table.insert(items, "%#DiagnosticError#" .. diagnostics.Error .. num_errors .. "%#StatusLine#")
            end
            if num_warns > 0 then
                table.insert(items, "%#DiagnosticWarn#" .. diagnostics.Warn .. num_warns .. "%#StatusLine#")
            end
            if num_infos > 0 then
                table.insert(items, "%#DiagnosticInfo#" .. diagnostics.Info .. num_infos .. "%#StatusLine#")
            end
            if num_hints > 0 then
                table.insert(items, "%#DiagnosticHint#" .. diagnostics.Hint .. num_hints .. "%#StatusLine#")
            end
        end

        if #items > 0 then
            table.insert(parts_left, "%(" .. table.concat(items, " ") .. "%)")
        end
    end

    -- ====================================================== MIDDLE =====================================================
    if gs then
        local git_head = gs.head
        local cwd_head = vim.g.gitsigns_head
        if git_head and cwd_head and git_head ~= cwd_head then
            table.insert(parts_mid, "%#NeogitBranch#" .. "" .. cwd_head .. "" .. git_head .. "%#StatusLine#")
        elseif git_head and git_head ~= "" then
            table.insert(parts_mid, "%#NeogitBranch#" .. git_head .. "%#StatusLine#")
        end
    end

    -- ====================================================== RIGHT ======================================================
    do
        local clients = {}
        for _, c in ipairs(vim.lsp.get_clients({ buffer = 0 })) do
            -- filter out null-ls or whatever you don't care about
            if c.name ~= "typos_lsp:" then
                table.insert(clients, c.name)
            end
        end
        if #clients > 0 then
            table.insert(parts_right, " " .. table.concat(clients, ","))
        end
    end

    local keymap_name = vim.b.keymap_name
    if keymap_name and keymap_name ~= "" then
        table.insert(parts_right, string.format("<%s> ", keymap_name))
    end

    if vim.o.busy > 0 then
        table.insert(parts_right, "◐ ")
    end

    if vim.o.ruler then
        if vim.o.rulerformat == "" then
            table.insert(parts_right, "%-14.(%l,%c%V%) %P")
        else
            table.insert(parts_right, vim.o.rulerformat)
        end
    end

    -- ====================================================== DONE =======================================================
    local stl = table.concat({
        table.concat(parts_left, " "),
        "%=",
        table.concat(parts_mid, " "),
        "%=",
        table.concat(parts_right, " "),
    }, " ")

    return stl
end

vim.o.statusline = "%!v:lua._custom_statusline()"

_G._custom_statusline = statusline
