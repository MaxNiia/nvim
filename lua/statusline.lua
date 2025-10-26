local function statusline()
    local parts_left  = {}
    local parts_mid   = {}
    local parts_right = {}
    -- ====================================================== LEFT =======================================================
    local gs          = vim.b.gitsigns_status_dict
    table.insert(parts_left, "%<%f %h%w%m%r")

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

        local num_errors  = count_diagnostics(vim.diagnostic.severity.ERROR)
        local num_warns   = count_diagnostics(vim.diagnostic.severity.WARN)
        local num_infos   = count_diagnostics(vim.diagnostic.severity.INFO)
        local num_hints   = count_diagnostics(vim.diagnostic.severity.HINT)

        local diagnostics = require("icons").diagnostics

        local items       = {}

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

        if #items > 0 then
            table.insert(parts_left, "%(" .. table.concat(items, " ") .. "%)")
        end
    end

    -- ====================================================== MIDDLE =====================================================
    if gs then
        local git_head = gs.head
        if git_head ~= "" then
            table.insert(parts_mid, "[" .. git_head ..  "]")
        end
    end

    -- ====================================================== RIGHT ======================================================
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
