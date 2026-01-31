local function set_current_issue(issue_key)
    vim.g.Jira_current_issue = issue_key
    vim.cmd("redrawstatus")
end

local function jira_picker(cmd, action_fn, opts)
    opts = opts or {}
    local output = vim.fn.systemlist(cmd)

    if vim.v.shell_error ~= 0 or #output == 0 then
        Snacks.notify.error("Jira command failed", { title = "Jira" })
        return
    end

    local items = {}
    for _, line in ipairs(output) do
        local parts = {}
        for _, part in ipairs(vim.split(line, "\t")) do
            if part ~= "" then
                table.insert(parts, part)
            end
        end
        local key = parts[2] or ""
        local summary = parts[3] or ""
        local status = parts[#parts] or ""
        local display = string.format("%s: %s [%s]", key, summary, status)
        table.insert(items, { text = display, data = line })
    end

    Snacks.picker.pick({
        title = opts.title or "Jira",
        items = items,
        format = "text",
        layout = { preset = "default", preview = false },
        confirm = function(picker, item)
            picker:close()
            if item and action_fn then
                action_fn(item)
            end
        end,
    })
end

local function extract_issue_key(line)
    return line:match("([A-Z]+%-[0-9]+)")
end

local function show_issue_in_buffer(issue_key)
    local lines = vim.fn.systemlist("jira issue view " .. issue_key .. " --plain")
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].filetype = "markdown"
    vim.api.nvim_set_current_buf(buf)
end

local function jira_my_issues()
    jira_picker('jira issue list -a$(jira me) -s~"Done" -s~"Closed" --plain --no-headers', function(item)
        local key = extract_issue_key(item.data)
        if key then
            set_current_issue(key)
            show_issue_in_buffer(key)
        end
    end, { title = "My Issues" })
end

local function jira_by_status()
    jira_picker('echo "In Progress\nIn Review\nTodo\nDone"', function(status_item)
        jira_picker(
            string.format('jira issue list -a$(jira me) -s"%s" --plain --no-headers', status_item.data),
            function(issue_item)
                local key = extract_issue_key(issue_item.data)
                if key then
                    set_current_issue(key)
                    show_issue_in_buffer(key)
                end
            end,
            { title = status_item.data }
        )
    end, { title = "Select Status" })
end

local function paste_current_issue()
    local issue = vim.g.Jira_current_issue
    if not issue then
        Snacks.notify.warn("No current Jira issue set", { title = "Jira" })
        return
    end
    vim.api.nvim_paste(issue, true, -1)
end

local function display_current_issue()
    local issue = vim.g.Jira_current_issue
    if not issue then
        Snacks.notify.warn("No current Jira issue set", { title = "Jira" })
        return
    end
    show_issue_in_buffer(issue)
end

local function comment_on_issue()
    local issue = vim.g.Jira_current_issue
    if not issue then
        Snacks.notify.warn("No current Jira issue set", { title = "Jira" })
        return
    end

    local buf = vim.api.nvim_create_buf(false, false)
    local temp_file = vim.fn.tempname() .. ".md"
    vim.api.nvim_buf_set_name(buf, temp_file)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
        "# Add comment to " .. issue,
        "# Save this buffer to post the comment",
        "# Close without saving to cancel",
        "",
    })
    vim.bo[buf].filetype = "markdown"
    vim.bo[buf].bufhidden = "wipe"
    vim.api.nvim_set_current_buf(buf)

    vim.api.nvim_create_autocmd("BufWritePost", {
        buffer = buf,
        once = true,
        callback = function()
            local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
            local comment_lines = {}
            for _, line in ipairs(lines) do
                if not line:match("^#") then
                    table.insert(comment_lines, line)
                end
            end
            local comment = table.concat(comment_lines, "\n"):gsub("^%s+", ""):gsub("%s+$", "")

            if comment == "" then
                Snacks.notify.warn("Comment is empty", { title = "Jira" })
                return
            end

            local result =
                vim.fn.system(string.format("jira issue comment add %s %s", issue, vim.fn.shellescape(comment)))

            if vim.v.shell_error == 0 then
                Snacks.notify("Comment added to " .. issue, { title = "Jira" })
                vim.api.nvim_buf_delete(buf, { force = true })
            else
                Snacks.notify.error("Failed to add comment: " .. result, { title = "Jira" })
            end
        end,
    })
end

local function quick_issue_info()
    local issue = vim.g.Jira_current_issue
    if not issue then
        Snacks.notify.warn("No current Jira issue set", { title = "Jira" })
        return
    end

    local output = vim.fn.systemlist(string.format("jira issue view %s --plain", issue))
    if vim.v.shell_error ~= 0 or #output == 0 then
        Snacks.notify.error("Failed to get issue info", { title = "Jira" })
        return
    end

    local info_lines = {}
    local max_lines = math.min(5, #output)
    for i = 1, max_lines do
        table.insert(info_lines, output[i])
    end

    Snacks.notify(table.concat(info_lines, "\n"), { title = issue, timeout = 5000 })
end

local function copy_issue_url()
    local issue = vim.g.Jira_current_issue
    if not issue then
        Snacks.notify.warn("No current Jira issue set", { title = "Jira" })
        return
    end

    local config_file = vim.fn.expand("~/.config/.jira/.config.yml")
    local config = vim.fn.readfile(config_file)
    local base_url = ""

    for _, line in ipairs(config) do
        local url = line:match("^server:%s*(.+)")
        if url then
            base_url = url
            break
        end
    end

    if base_url == "" then
        Snacks.notify.error("Could not find Jira server URL", { title = "Jira" })
        return
    end

    local url = base_url .. "/browse/" .. issue
    vim.fn.setreg("+", url)
    Snacks.notify("Copied: " .. url, { title = "Jira" })
end

local function open_in_browser()
    local issue = vim.g.Jira_current_issue
    if not issue then
        Snacks.notify.warn("No current Jira issue set", { title = "Jira" })
        return
    end

    local config_file = vim.fn.expand("~/.config/.jira/.config.yml")
    local config = vim.fn.readfile(config_file)
    local base_url = ""

    for _, line in ipairs(config) do
        local url = line:match("^server:%s*(.+)")
        if url then
            base_url = url
            break
        end
    end

    if base_url == "" then
        Snacks.notify.error("Could not find Jira server URL", { title = "Jira" })
        return
    end

    local url = base_url .. "/browse/" .. issue
    local result = vim.fn.system(string.format("xdg-open %s", vim.fn.shellescape(url)))

    if vim.v.shell_error == 0 then
        Snacks.notify("Opened in browser: " .. issue, { title = "Jira" })
    else
        Snacks.notify.error("Failed to open browser: " .. result, { title = "Jira" })
    end
end

local function view_issue_history()
    local issue = vim.g.Jira_current_issue
    if not issue then
        Snacks.notify.warn("No current Jira issue set", { title = "Jira" })
        return
    end

    local lines = vim.fn.systemlist(string.format("jira issue view %s --plain --comments 20", issue))

    if vim.v.shell_error ~= 0 or #lines == 0 then
        Snacks.notify.error("Failed to get history", { title = "Jira" })
        return
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].filetype = "markdown"
    vim.api.nvim_set_current_buf(buf)
end

local function view_specific_issue()
    vim.ui.input({
        prompt = "Enter Jira issue key: ",
    }, function(issue_key)
        if not issue_key or issue_key == "" then
            return
        end

        issue_key = issue_key:upper():match("([A-Z]+%-[0-9]+)")
        if not issue_key then
            Snacks.notify.error("Invalid issue key format", { title = "Jira" })
            return
        end

        local lines = vim.fn.systemlist("jira issue view " .. issue_key .. " --plain")

        if vim.v.shell_error ~= 0 or #lines == 0 then
            Snacks.notify.error("Issue not found: " .. issue_key, { title = "Jira" })
            return
        end

        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.bo[buf].filetype = "markdown"
        vim.api.nvim_set_current_buf(buf)
        Snacks.notify("Viewing: " .. issue_key, { title = "Jira" })
    end)
end

vim.keymap.set("n", "<leader>hi", jira_my_issues, { desc = "My issues" })
vim.keymap.set("n", "<leader>hs", jira_by_status, { desc = "By status" })
vim.keymap.set("n", "<leader>hp", paste_current_issue, { desc = "Paste current issue" })
vim.keymap.set("n", "<leader>hd", display_current_issue, { desc = "Display current issue" })
vim.keymap.set("n", "<leader>hc", comment_on_issue, { desc = "Comment on issue" })
vim.keymap.set("n", "<leader>hq", quick_issue_info, { desc = "Quick issue info" })
vim.keymap.set("n", "<leader>hy", copy_issue_url, { desc = "Copy issue URL" })
vim.keymap.set("n", "<leader>ho", open_in_browser, { desc = "Open in browser" })
vim.keymap.set("n", "<leader>hh", view_issue_history, { desc = "View history" })
vim.keymap.set("n", "<leader>hv", view_specific_issue, { desc = "View specific issue" })
