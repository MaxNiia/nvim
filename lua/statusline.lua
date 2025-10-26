local function statusline()
    local parts_left  = {}
    local parts_mid   = {}
    local parts_right = {}
    -- ====================================================== LEFT =======================================================
    table.insert(parts_left, "%<%f %h%w%m%r")

    if vim.o.showcmdloc == "statusline" then
        table.insert(parts_right, "%-10.S ")
    end

    -- ====================================================== MIDDLE =====================================================
    local git_status = vim.b.gitsigns_status or ""
    if git_status ~= "" then
        table.insert(parts_mid, git_status)
    end

    local git_head = vim.b.gitsigns_head or ""
    if git_head ~= "" then
        table.insert(parts_mid, git_head)
    end

    -- ====================================================== RIGHT ======================================================
    local keymap_name = vim.b.keymap_name
    if keymap_name and keymap_name ~= "" then
        table.insert(parts_right, string.format("<%s> ", keymap_name))
    end

    if vim.o.busy > 0 then
        table.insert(parts_right, "◐ ")
    end

    do
        local diag_status = ""
        local ok, diag = pcall(require, "vim.diagnostic")
        if ok and diag and diag.status then
            local s = diag.status()
            if s and s ~= "" then
                diag_status = s .. " "
            end
        end
        if diag_status ~= "" then
            table.insert(parts_right, "%(" .. diag_status .. "%)")
        end
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
