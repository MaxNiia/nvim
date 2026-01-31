M = {}

M.dirs = {
    notes_dir = vim.g.notes_directory,
    journal_dir = vim.g.notes_directory .. "Journal",
    issues_dir = vim.g.notes_directory .. "Issues",
}

function M.get_tags_from_file(file)
    local ok, content = pcall(vim.fn.readfile, file)
    if not ok then
        return {}
    end

    local tags = {}
    local seen = {}

    for _, line in ipairs(content) do
        if not line:match("^#+ ") then
            for tag in line:gmatch("#([%w_/-]+)") do
                if not seen[tag] then
                    table.insert(tags, tag)
                    seen[tag] = true
                end
            end
        end
    end

    return tags
end

function M.get_tags_from_buffer()
    return M.get_tags_from_file(vim.fs.normalize(vim.fn.expand("%:p") --[[@as string]]))
end

function M.get_all_tags()
    local all_tags = {}
    local tag_count = {}

    local files = vim.fn.globpath(M.dirs.notes_dir, "**/*.md", false, true)

    for _, file in ipairs(files) do
        local tags = M.get_tags_from_file(file)
        for _, tag in ipairs(tags) do
            tag_count[tag] = (tag_count[tag] or 0) + 1
        end
    end

    -- Convert to sorted array
    for tag, count in pairs(tag_count) do
        table.insert(all_tags, { tag = tag, count = count })
    end

    table.sort(all_tags, function(a, b)
        return a.count > b.count
    end)

    return all_tags
end

-- Find all notes containing a specific tag
function M.find_notes_with_tag(tag)
    local files = vim.fn.globpath(M.dirs.notes_dir, "**/*.md", false, true)
    local matches = {}

    -- Escape special pattern characters in tag
    local escaped_tag = tag:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")

    for _, file in ipairs(files) do
        local content = table.concat(vim.fn.readfile(file), "\n")
        -- Match tag followed by non-word char or end of string
        if content:match("#" .. escaped_tag .. "[^%w_/-]") or content:match("#" .. escaped_tag .. "$") then
            local title = vim.fn.readfile(file, "", 1)[1] or vim.fn.fnamemodify(file, ":t:r")
            table.insert(matches, {
                file = file,
                title = title:gsub("^#+ ", ""),
                display = string.format("%s (%s)", title:gsub("^#+ ", ""), vim.fn.fnamemodify(file, ":~:.")),
            })
        end
    end

    return matches
end

-- Show tag picker (fuzzy find by tag)
function M.tag_picker()
    local tags = M.get_all_tags()

    if #tags == 0 then
        vim.notify("No tags found in notes", vim.log.levels.INFO)
        return
    end

    local items = vim.tbl_map(function(item)
        return {
            text = string.format("#%-30s %3d notes", item.tag, item.count),
            tag = item.tag,
        }
    end, tags)

    vim.ui.select(items, {
        prompt = "Select tag:",
        format_item = function(item)
            return item.text
        end,
    }, function(selected)
        if selected then
            M.open_notes_with_tag(selected.tag)
        end
    end)
end

-- Open notes with specific tag
function M.open_notes_with_tag(tag)
    local matches = M.find_notes_with_tag(tag)

    if #matches == 0 then
        vim.notify(string.format("No notes found with tag #%s", tag), vim.log.levels.INFO)
        return
    end

    if #matches == 1 then
        vim.cmd.edit(matches[1].file)
        return
    end

    vim.ui.select(matches, {
        prompt = string.format("Notes with #%s:", tag),
        format_item = function(item)
            return item.display
        end,
    }, function(selected)
        if selected then
            vim.cmd.edit(selected.file)
        end
    end)
end

-- Tag autocomplete function
function M.tag_complete(findstart, base)
    if findstart == 1 then
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2]
        -- Find start of tag (# character)
        local before = line:sub(1, col)
        local start = before:find("#[%w_/-]*$")
        return start and start - 1 or col
    else
        -- Return matching tags
        local all_tags = M.get_all_tags()
        local matches = {}
        local base_clean = base:gsub("^#", "") -- Remove leading # if present

        for _, item in ipairs(all_tags) do
            if base_clean == "" or item.tag:match("^" .. vim.pesc(base_clean)) then
                table.insert(matches, {
                    word = "#" .. item.tag,
                    menu = string.format("(%d)", item.count),
                })
            end
        end
        return matches
    end
end

-- Find notes with similar tags to current note
function M.find_related_notes()
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_tags = M.get_tags_from_buffer()

    if #current_tags == 0 then
        vim.notify("Current note has no tags", vim.log.levels.INFO)
        return
    end

    local files = vim.fn.globpath(M.dirs.notes_dir, "**/*.md", false, true)
    local scores = {}

    for _, file in ipairs(files) do
        if file ~= current_file then
            local tags = M.get_tags_from_file(file)
            local matches = 0

            for _, tag in ipairs(current_tags) do
                if vim.tbl_contains(tags, tag) then
                    matches = matches + 1
                end
            end

            if matches > 0 then
                local title = vim.fn.readfile(file, "", 1)[1] or vim.fn.fnamemodify(file, ":t:r")
                scores[file] = {
                    score = matches,
                    title = title:gsub("^#+ ", ""),
                    display = string.format(
                        "%s [%d/%d tags] (%s)",
                        title:gsub("^#+ ", ""),
                        matches,
                        #current_tags,
                        vim.fn.fnamemodify(file, ":~:.")
                    ),
                }
            end
        end
    end

    -- Sort by similarity score
    local sorted = {}
    for file, data in pairs(scores) do
        table.insert(sorted, vim.tbl_extend("force", data, { file = file }))
    end
    table.sort(sorted, function(a, b)
        return a.score > b.score
    end)

    if #sorted == 0 then
        vim.notify("No related notes found", vim.log.levels.INFO)
        return
    end

    vim.ui.select(sorted, {
        prompt = "Related notes:",
        format_item = function(item)
            return item.display
        end,
    }, function(selected)
        if selected then
            vim.cmd.edit(selected.file)
        end
    end)
end

-- Find notes with multiple tags (AND/OR logic)
function M.find_notes_with_tags(tags, mode, opts)
    mode = mode or "AND"
    opts = opts or {}
    local exclude = opts.exclude or {}

    local files = vim.fn.globpath(M.dirs.notes_dir, "**/*.md", false, true)
    local matches = {}

    for _, file in ipairs(files) do
        local file_tags = M.get_tags_from_file(file)
        local match = false

        if mode == "AND" then
            match = true
            for _, tag in ipairs(tags) do
                if not vim.tbl_contains(file_tags, tag) then
                    match = false
                    break
                end
            end
        elseif mode == "OR" then
            for _, tag in ipairs(tags) do
                if vim.tbl_contains(file_tags, tag) then
                    match = true
                    break
                end
            end
        end

        -- Check exclusions
        if match then
            for _, ex_tag in ipairs(exclude) do
                if vim.tbl_contains(file_tags, ex_tag) then
                    match = false
                    break
                end
            end
        end

        if match then
            local title = vim.fn.readfile(file, "", 1)[1] or vim.fn.fnamemodify(file, ":t:r")
            table.insert(matches, {
                file = file,
                title = title:gsub("^#+ ", ""),
            })
        end
    end

    return matches
end

-- Parse hierarchical tag parts
function M.parse_hierarchical_tag(tag)
    return vim.split(tag, "/", { plain = true })
end

-- Find notes by tag prefix (hierarchical)
function M.find_notes_by_tag_prefix(prefix)
    local files = vim.fn.globpath(M.dirs.notes_dir, "**/*.md", false, true)
    local matches = {}

    for _, file in ipairs(files) do
        local tags = M.get_tags_from_file(file)
        for _, tag in ipairs(tags) do
            if vim.startswith(tag, prefix) then
                local title = vim.fn.readfile(file, "", 1)[1] or vim.fn.fnamemodify(file, ":t:r")
                table.insert(matches, {
                    file = file,
                    title = title:gsub("^#+ ", ""),
                    tag = tag,
                })
                break
            end
        end
    end

    return matches
end

-- Rename tag across all notes
function M.rename_tag(old_tag, new_tag)
    local files = vim.fn.globpath(M.dirs.notes_dir, "**/*.md", false, true)
    local count = 0

    for _, file in ipairs(files) do
        local lines = vim.fn.readfile(file)
        local modified = false

        for i, line in ipairs(lines) do
            -- Match tag with word boundary
            local pattern = "#" .. vim.pesc(old_tag) .. "([^%w_/-])"
            local replacement = "#" .. new_tag .. "%1"
            local new_line, replacements = line:gsub(pattern, replacement)

            if replacements > 0 then
                lines[i] = new_line
                modified = true
            end

            -- Also handle end of line
            pattern = "#" .. vim.pesc(old_tag) .. "$"
            replacement = "#" .. new_tag
            new_line, replacements = lines[i]:gsub(pattern, replacement)

            if replacements > 0 then
                lines[i] = new_line
                modified = true
            end
        end

        if modified then
            vim.fn.writefile(lines, file)
            count = count + 1
        end
    end

    vim.notify(string.format("Renamed #%s to #%s in %d files", old_tag, new_tag, count))
end

-- Show tag cloud in floating window
function M.show_tag_cloud()
    local tags = M.get_all_tags()

    if #tags == 0 then
        vim.notify("No tags found", vim.log.levels.INFO)
        return
    end

    local lines = { "# Tag Cloud", "" }

    for _, item in ipairs(tags) do
        table.insert(lines, string.format("  %-30s %3d notes", "#" .. item.tag, item.count))
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].filetype = "markdown"
    vim.bo[buf].modifiable = false

    local width = 50
    local height = math.min(#lines, 25)

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = "minimal",
        border = "rounded",
        title = " Tags ",
        title_pos = "center",
    })

    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, nowait = true })
    vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { buffer = buf, nowait = true })
end

function M.create_quick_note()
    vim.ui.input({ prompt = "Note title: " }, function(title)
        if not title or title == "" then
            return
        end

        -- Sanitize title for filename
        local filename = title:lower():gsub("%s+", "-"):gsub("[^%w%-]", "")
        local filepath = string.format("%s/%s.md", M.dirs.notes_dir, filename)

        -- Create directory if needed
        vim.fn.mkdir(M.dirs.notes_dir, "p")

        -- Create note with title as header
        vim.cmd.edit(filepath)
        if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
            vim.api.nvim_buf_set_lines(0, 0, 1, false, {
                "# " .. title,
                "",
                "",
            })
            vim.api.nvim_win_set_cursor(0, { 3, 0 })
        end
    end)
end

-- Find recent notes
function M.find_recent_notes(limit)
    limit = limit or 20
    local files = vim.fn.globpath(M.dirs.notes_dir, "**/*.md", false, true)

    local file_times = {}
    for _, file in ipairs(files) do
        local mtime = vim.fn.getftime(file)
        table.insert(file_times, { file = file, mtime = mtime })
    end

    table.sort(file_times, function(a, b)
        return a.mtime > b.mtime
    end)

    local recent = {}
    for i = 1, math.min(limit, #file_times) do
        local file = file_times[i].file
        local title = vim.fn.readfile(file, "", 1)[1] or vim.fn.fnamemodify(file, ":t:r")
        local time_ago = os.date("%Y-%m-%d %H:%M", file_times[i].mtime)
        table.insert(recent, {
            file = file,
            title = title:gsub("^#+ ", ""),
            display = string.format("%s [%s]", title:gsub("^#+ ", ""), time_ago),
        })
    end

    vim.ui.select(recent, {
        prompt = "Recent notes:",
        format_item = function(item)
            return item.display
        end,
    }, function(selected)
        if selected then
            vim.cmd.edit(selected.file)
        end
    end)
end

-- Insert tag at cursor
function M.insert_tag()
    local tags = M.get_all_tags()

    if #tags == 0 then
        vim.ui.input({ prompt = "New tag: " }, function(tag)
            if tag and tag ~= "" then
                local clean_tag = tag:gsub("^#", "")
                vim.api.nvim_put({ " #" .. clean_tag }, "c", true, true)
            end
        end)
        return
    end

    local items = vim.tbl_map(function(item)
        return {
            text = string.format("#%s (%d)", item.tag, item.count),
            tag = item.tag,
        }
    end, tags)

    -- Add "New tag..." option
    table.insert(items, 1, { text = "[New tag...]", tag = nil })

    vim.ui.select(items, {
        prompt = "Insert tag:",
        format_item = function(item)
            return item.text
        end,
    }, function(selected)
        if not selected then
            return
        end

        if selected.tag then
            vim.api.nvim_put({ " #" .. selected.tag }, "c", true, true)
        else
            vim.ui.input({ prompt = "New tag: " }, function(tag)
                if tag and tag ~= "" then
                    local clean_tag = tag:gsub("^#", "")
                    vim.api.nvim_put({ " #" .. clean_tag }, "c", true, true)
                end
            end)
        end
    end)
end

function M.find_todos()
    local files = vim.fn.globpath(M.dirs.notes_dir, "**/*.md", false, true)
    local checkboxes = {}

    for _, file in ipairs(files) do
        local ok, lines = pcall(vim.fn.readfile, file)
        if ok then
            for line_num, line in ipairs(lines) do
                -- Match unchecked checkbox patterns: - [ ] or * [ ]
                if line:match("^%s*[-*]%s+%[%s%]") then
                    local content = line:gsub("^%s*[-*]%s+%[%s%]%s*", "")
                    local filename = vim.fn.fnamemodify(file, ":t:r")
                    table.insert(checkboxes, {
                        file = file,
                        line_num = line_num,
                        content = content,
                        display = string.format("%s:%d - %s", filename, line_num, content),
                    })
                end
            end
        end
    end

    if #checkboxes == 0 then
        vim.notify("No unchecked checkboxes found", vim.log.levels.INFO)
        return
    end

    vim.ui.select(checkboxes, {
        prompt = string.format("Unchecked todos (%d):", #checkboxes),
        format_item = function(item)
            return item.display
        end,
    }, function(selected)
        if selected then
            vim.cmd.edit(selected.file)
            vim.api.nvim_win_set_cursor(0, { selected.line_num, 0 })
        end
    end)
end

-- Open note for current Jira issue
function M.open_jira_issue_note()
    local jira_issue = vim.g.Jira_current_issue

    if not jira_issue or jira_issue == "" then
        vim.notify("No Jira issue currently selected", vim.log.levels.WARN)
        return
    end

    -- Create Issues directory if needed
    vim.fn.mkdir(M.dirs.issues_dir, "p")

    local filename = string.format("%s/%s.md", M.dirs.issues_dir, jira_issue)
    vim.cmd.edit(filename)

    -- Add header if new file
    if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
        local date = os.date("%Y-%m-%d")
        vim.api.nvim_buf_set_lines(0, 0, 1, false, {
            "# " .. jira_issue,
            "",
            string.format("Created: %s", date),
            "",
            "## Notes",
            "",
            "",
        })
        vim.api.nvim_win_set_cursor(0, { 7, 0 })
    end
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.fn.matchadd("Tag", "#[%w_/-]\\+")
    end,
})

-- Define highlight group
vim.api.nvim_set_hl(0, "Tag", {
    fg = "#89b4fa",
    bold = true,
})

-- Setup tag autocomplete for markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.bo.omnifunc = "v:lua.require'notes'.tag_complete"
    end,
})

local key = vim.keymap.set

key("n", "<leader>nd", function()
    local date = os.date("%Y-%m-%d")
    local journal_dir = M.dirs.journal_dir
    local journal_file = string.format("%s/%s.md", journal_dir, date)

    -- Create directory if it doesn't exist
    vim.fn.mkdir(journal_dir, "p")

    -- Open the journal file
    vim.cmd.edit(journal_file)

    -- Add header if new file
    if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
        local day_name = os.date("%A")
        vim.api.nvim_buf_set_lines(0, 0, 1, false, {
            "# " .. day_name .. ", " .. date,
            "",
            "",
        })
        vim.api.nvim_win_set_cursor(0, { 3, 0 })
    end
end, { desc = "Open today's journal" })

key("n", "<leader>nc", function()
    local date = os.date("%Y-%m-%d")
    local line = string.format("- [ ] %s: ", date)
    local row = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, row, row, false, { line })
    -- Move cursor to end of line in insert mode
    vim.api.nvim_win_set_cursor(0, { row + 1, #line })
    vim.cmd.startinsert({ bang = true })
end, { desc = "Create checkbox with date" })

key("n", "<leader>nt", function()
    local line = vim.api.nvim_get_current_line()
    local new_line

    if line:match("%[%s%]") then
        -- Unticked -> ticked
        new_line = line:gsub("%[%s%]", "[x]", 1)
    elseif line:match("%[x%]") or line:match("%[X%]") then
        -- Ticked -> unticked
        new_line = line:gsub("%[[xX]%]", "[ ]", 1)
    else
        -- No checkbox found, do nothing
        return
    end

    local row = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
end, { desc = "Toggle checkbox" })

key("n", "<leader>nf", function()
    Snacks.picker.files({ cwd = M.dirs.notes_dir })
end, { desc = "Find notes" })
key("n", "<leader>ng", function()
    Snacks.picker.grep({ cwd = M.dirs.notes_dir })
end, { desc = "Grep notes" })
key("n", "<leader>nt", function()
    local tags = M.get_all_tags()
    if #tags == 0 then
        vim.notify("No tags found in notes", vim.log.levels.INFO)
        return
    end
    Snacks.picker({
        title = "Tags",
        items = vim.tbl_map(function(item)
            return {
                text = item.tag,
                tag = item.tag,
                count = item.count,
            }
        end, tags),
        format = function(item)
            return {
                { "#" .. item.tag, "Tag" },
                { " (" .. item.count .. ")", "Comment" },
            }
        end,
        confirm = function(picker, item)
            picker:close()
            if item then
                Snacks.picker.grep({
                    cwd = M.dirs.notes_dir,
                    search = "#" .. item.tag .. "\\b",
                })
            end
        end,
    })
end, { desc = "Find notes by tag" })
key("n", "<leader>nw", M.show_tag_cloud, { desc = "Show tag cloud" })
key("n", "<leader>nr", M.find_related_notes, { desc = "Find related notes" })
key("n", "<leader>nR", M.find_recent_notes, { desc = "Recent notes" })
key("n", "<leader>nn", M.create_quick_note, { desc = "Create new note" })
key("n", "<leader>ni", M.insert_tag, { desc = "Insert tag" })
key("n", "<leader>nj", M.open_jira_issue_note, { desc = "Open Jira issue note" })
key("n", "<leader>no", M.find_todos, { desc = "Find todos" })

return M
