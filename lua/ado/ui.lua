local Init = require("ado")
local Api = require("ado.api")
local CommentCtx = require("ado.comment_context")
local UI = {}

local open_comment_buffer
local render_thread_in_editor
local open_thread_sidebar

local function has_telescope()
    if Init.cfg.picker == "builtin" or Init.cfg.picker == "snacks" then
        return false
    end
    local ok = pcall(require, "telescope")
    return ok
end

local function has_snacks()
    if Init.cfg.picker == "builtin" or Init.cfg.picker == "telescope" then
        return false
    end
    local ok, _ = pcall(require, "snacks")
    return ok
end

local function open_url(url)
    local cmd
    if vim.fn.has("mac") == 1 then
        cmd = { "open", url }
    elseif vim.fn.has("unix") == 1 then
        cmd = { "xdg-open", url }
    elseif vim.fn.has("win32") == 1 then
        cmd = { "cmd", "/c", "start", url }
    end
    if cmd then
        vim.system(cmd, { detach = true })
    end
end

local function pad(str, n)
    n = n or 40
    str = tostring(str or "")
    if #str >= n then
        return str:sub(1, n - 1) .. "…"
    end
    return str .. string.rep(" ", n - #str)
end

local function simple_picker(lines, on_select, title)
    local buf = vim.api.nvim_create_buf(false, true)
    local width = math.max(60, math.floor(vim.o.columns * 0.7))
    local height = math.min(#lines + 2, math.floor(vim.o.lines * 0.7))
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        style = "minimal",
        border = "rounded",
        row = row,
        col = col,
        width = width,
        height = height,
        title = title or "azure-devops.nvim",
        title_pos = "center",
    })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.keymap.set("n", "<CR>", function()
        local lnum = vim.api.nvim_win_get_cursor(0)[1]
        on_select(lnum)
    end, { buffer = buf, nowait = true })
    vim.keymap.set("n", "q", function()
        vim.api.nvim_win_close(0, true)
    end, { buffer = buf })
end

-- helpers: git/paths/selection
local function current_branch()
    local out = vim.fn.systemlist({ "git", "rev-parse", "--abbrev-ref", "HEAD" })[1]
    if out and out ~= "" then
        return out
    end
    return nil
end

local function git_root()
    local out = vim.fn.systemlist({ "git", "rev-parse", "--show-toplevel" })[1]
    if out and out ~= "" then
        return out
    end
    return nil
end

local function relpath_from_git_root(filepath)
    local root = git_root()
    local virtual = filepath:match("%.git//[^/]+/(.+)$")
    if virtual and virtual ~= "" then
        return CommentCtx.to_repo_relative("/" .. virtual, root)
    end
    local abs = vim.fn.fnamemodify(filepath, ":p")
    if root and root ~= "" then
        return CommentCtx.to_repo_relative(abs, root)
    end
    local rel = vim.fn.fnamemodify(abs, ":p:.")
    return CommentCtx.to_repo_relative(rel)
end

local function select_comment_side(provided_side, cb)
    local normalized
    if type(provided_side) == "string" then
        local lower = provided_side:lower()
        if lower == "left" or lower == "right" then
            normalized = lower
        end
    end
    if normalized then
        cb(normalized)
        return
    end
    if vim.wo.diff then
        local choices = {
            { key = "right", label = "Right (current changes)" },
            { key = "left", label = "Left (base / original)" },
        }
        vim.ui.select(choices, {
            prompt = "Comment on which diff side?",
            format_item = function(item)
                return item.label
            end,
        }, function(sel)
            if sel then
                cb(sel.key)
            end
        end)
        return
    end
    cb("right")
end

local function gather_context_lines(bufnr, sline, eline)
    if not bufnr or not vim.api.nvim_buf_is_loaded(bufnr) then
        return {}
    end
    local total = vim.api.nvim_buf_line_count(bufnr)
    if total == 0 then
        return {}
    end
    local start_line = math.max(1, math.min(sline, eline))
    local end_line = math.max(start_line, math.min(total, math.max(sline, eline)))
    return vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
end

local function read_file_context(file_rel, line, span)
    if not file_rel or file_rel == "(general)" then
        return {}
    end
    local root = git_root()
    if not root or root == "" then
        return {}
    end
    local rel = file_rel:gsub("^/", "")
    local path = root .. "/" .. rel
    if vim.fn.filereadable(path) ~= 1 then
        return {}
    end
    local lines = vim.fn.readfile(path)
    if not lines or #lines == 0 then
        return {}
    end
    span = span or 2
    local total = #lines
    local start_line, end_line
    if span == math.huge then
        start_line = 1
        end_line = total
    else
        local center = math.max(1, math.floor(line or 1))
        start_line = math.max(1, center - span)
        end_line = math.min(total, center + span)
    end
    local context = {}
    for i = start_line, end_line do
        context[#context + 1] = lines[i]
    end
    return context
end

local function thread_summary(thread)
    local first_comment = (thread.comments and thread.comments[1]) or {}
    local content = first_comment and first_comment.content or ""
    if type(content) ~= "string" then
        content = ""
    end
    content = content:gsub("\r?\n", " ")
    if #content > 80 then
        content = content:sub(1, 77) .. "..."
    end
    return content ~= "" and content or "(no content)"
end

local function thread_file_path(thread)
    local tc = thread and thread.threadContext
    if type(tc) ~= "table" then
        return nil
    end
    return tc.filePath or tc.fileName or tc.path
end

local function thread_line_hint(thread)
    local tc = thread and thread.threadContext
    if type(tc) ~= "table" then
        return nil
    end
    local r = tc.rightFileStart or tc.rightFileEnd
    local l = tc.leftFileStart or tc.leftFileEnd
    local loc = r or l
    return loc and loc.line or nil
end

local function extract_selection(bufnr, sline, scol, eline, ecol)
    if not bufnr or not vim.api.nvim_buf_is_loaded(bufnr) then
        return nil
    end
    if eline < sline or (eline == sline and ecol < scol) then
        sline, eline = eline, sline
        scol, ecol = ecol, scol
    end
    if sline <= 0 or eline <= 0 then
        return nil
    end
    local lines = vim.api.nvim_buf_get_lines(bufnr, sline - 1, eline, false)
    if #lines == 0 then
        return nil
    end
    local start_col = math.max(1, scol)
    local end_col = math.max(1, ecol)
    lines[1] = string.sub(lines[1], start_col)
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
    return {
        text = table.concat(lines, "\n"),
        sline = sline,
        scol = start_col,
        eline = eline,
        ecol = end_col,
    }
end

local function find_thread_by_id(threads, thread_id)
    for _, t in ipairs(threads or {}) do
        if tonumber(t.id) == tonumber(thread_id) then
            return t
        end
    end
    return nil
end

local function get_visual_selection(bufnr)
    -- Returns { text, sline, scol, eline, ecol } or nil
    local s = vim.fn.getpos("'<")
    local e = vim.fn.getpos("'>")
    if s[2] == 0 or e[2] == 0 then
        return nil
    end
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    return extract_selection(bufnr, s[2], s[3], e[2], e[3])
end

local function build_comment_context(pr_id, opts)
    opts = opts or {}
    local buf = opts.bufnr
    if not buf or not vim.api.nvim_buf_is_loaded(buf) then
        buf = vim.api.nvim_get_current_buf()
    end
    local file_abs = vim.api.nvim_buf_get_name(buf)
    if not file_abs or file_abs == "" then
        vim.notify("Azure DevOps: buffer has no file name", vim.log.levels.ERROR)
        return nil
    end
    local file_rel = relpath_from_git_root(file_abs)
    local sel
    if opts.selection then
        sel = extract_selection(
            buf,
            opts.selection.sline,
            opts.selection.scol,
            opts.selection.eline,
            opts.selection.ecol
        )
    elseif opts.use_selection then
        sel = get_visual_selection(buf)
    end
    local cursor_line = opts.cursor_line or vim.api.nvim_win_get_cursor(0)[1]
    local ctx = {
        pr_id = pr_id,
        file_rel = file_rel,
        file_abs = file_abs,
        source_bufnr = buf,
        default_text = sel and sel.text or "",
        suggestion = opts.suggestion or false,
    }
    if sel and sel.text and sel.text ~= "" then
        ctx.kind = "selection"
        ctx.sline = sel.sline
        ctx.scol = sel.scol
        ctx.eline = sel.eline
        ctx.ecol = sel.ecol
        ctx.range_label = string.format("%s:%d-%d", file_rel, sel.sline, sel.eline)
    else
        ctx.kind = "line"
        ctx.line = cursor_line
        ctx.range_label = string.format("%s:%d", file_rel, cursor_line)
    end
    local start_line = ctx.kind == "selection" and ctx.sline or ctx.line
    local end_line = ctx.kind == "selection" and ctx.eline or ctx.line
    ctx.context_lines = gather_context_lines(buf, start_line, end_line)
    if ctx.suggestion then
        if ctx.kind ~= "selection" then
            vim.notify(
                "Azure DevOps: suggestions require a visual selection; falling back to line.",
                vim.log.levels.WARN
            )
        end
        local inner = sel and sel.text
        if (not inner or inner == "") and ctx.context_lines then
            inner = table.concat(ctx.context_lines, "\n")
        end
        ctx.default_text = string.format("```suggestion\n%s\n```", inner or "")
    end
    return ctx
end

local function build_reply_context(pr_id, thread)
    if not (thread and thread.id) then
        return nil
    end
    local file_rel = thread_file_path(thread) or "(general)"
    local line = thread_line_hint(thread)
    local label
    if file_rel == "(general)" then
        label = string.format("Thread #%s", thread.id)
    else
        label = line and string.format("%s:%s", file_rel, line) or file_rel
    end
    local transcript = {}
    for _, c in ipairs(thread.comments or {}) do
        local by = (c.author and c.author.displayName) or (c.author and c.author.id) or "unknown"
        local dt = (c.publishedDate or c.lastUpdatedDate or ""):gsub("T", " "):gsub("Z", "")
        table.insert(transcript, string.format("%s — %s", by, dt))
        local body = (c.content or ""):gsub("\r\n", "\n")
        local parts = vim.split(body, "\n", { plain = true })
        for _, line_txt in ipairs(parts) do
            table.insert(transcript, "  " .. line_txt)
        end
        table.insert(transcript, "")
    end
    local ctx = {
        pr_id = pr_id,
        file_rel = file_rel,
        range_label = label,
        side = "right",
        thread_id = thread.id,
        default_text = "",
        context_lines = read_file_context(file_rel, line, math.huge),
        thread_comments = transcript,
        reply = true,
    }
    ctx.kind = "reply"
    return ctx
end

local function build_thread_items(data)
    local items = {}
    for _, t in ipairs(data.value or {}) do
        local st = t.status or "active"
        local should_include = true
        if UI._threads_filter == "active" then
            should_include = st == "active"
        elseif UI._threads_filter == "unresolved" then
            should_include = (st == "active" or st == "pending")
        end
        if should_include then
            items[#items + 1] = {
                id = t.id,
                status = st,
                file = thread_file_path(t) or "(general)",
                line = thread_line_hint(t),
                preview = thread_summary(t),
                _raw = t,
            }
        end
    end
    return items
end

local function open_reply_editor(pr_id, thread)
    local ctx = build_reply_context(pr_id, thread)
    if not ctx then
        return
    end
    select_comment_side(nil, function(side)
        ctx.side = side or "right"
        open_comment_buffer(ctx)
    end)
end

render_thread_in_editor = function(pr_number, thread, opts)
    if not thread then
        return
    end
    opts = opts or {}
    local buf = vim.api.nvim_create_buf(false, true)
    local header = {}
    local file = thread_file_path(thread) or "(general)"
    local line = thread_line_hint(thread)
    local title = string.format(
        "PR !%s — Thread #%s  %s%s",
        tostring(pr_number),
        tostring(thread.id),
        file,
        line and (":" .. line) or ""
    )
    header[#header + 1] = title
    header[#header + 1] = string.rep("─", math.max(#title, 40))
    header[#header + 1] = string.format("Status: %s", thread.status or "active")
    if thread.isDeleted then
        header[#header + 1] = "(deleted)"
    end
    header[#header + 1] = ""

    local lines = {}
    for _, c in ipairs(thread.comments or {}) do
        local by = (c.author and c.author.displayName) or (c.author and c.author.id) or "unknown"
        local dt = (c.publishedDate or c.lastUpdatedDate or ""):gsub("T", " "):gsub("Z", "")
        lines[#lines + 1] = string.format("%s  —  %s", by, dt)
        local body = (c.content or ""):gsub("\r\n", "\n")
        if body:find("\n") then
            for _, line_txt in ipairs(vim.split(body, "\n", { plain = true })) do
                lines[#lines + 1] = line_txt == "" and " " or line_txt
            end
        else
            lines[#lines + 1] = body
        end
        lines[#lines + 1] = ""
    end
    local display = {}
    for _, v in ipairs(header) do
        display[#display + 1] = v
    end
    for _, v in ipairs(lines) do
        display[#display + 1] = v
    end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, display)
    vim.bo[buf].modifiable = false
    vim.bo[buf].filetype = "markdown"

    local width = math.min(math.max(70, math.floor(vim.o.columns * 0.6)), vim.o.columns - 4)
    local height = math.min(math.max(10, #header + #lines + 2), math.floor(vim.o.lines * 0.6))
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        style = "minimal",
        border = "rounded",
        row = row,
        col = col,
        width = width,
        height = height,
        title = title,
        title_pos = "center",
    })

    local function do_reply()
        if opts.on_reply then
            opts.on_reply(thread)
        else
            open_reply_editor(pr_number, thread)
        end
    end

    vim.keymap.set("n", "q", function()
        pcall(vim.api.nvim_win_close, win, true)
    end, { buffer = buf, nowait = true })
    vim.keymap.set("n", "o", function()
        local pr_url = string.format(
            "https://dev.azure.com/%s/%s/_git/%s/pullrequest/%s",
            Init.cfg.org,
            Init.cfg.project,
            Init.cfg.repo,
            pr_number
        )
        local cmd = (vim.fn.has("mac") == 1 and { "open", pr_url })
            or (vim.fn.has("unix") == 1 and { "xdg-open", pr_url })
            or (vim.fn.has("win32") == 1 and { "cmd", "/c", "start", pr_url })
            or nil
        if cmd then
            vim.system(cmd, { detach = true })
        end
    end, { buffer = buf, nowait = true, desc = "Open PR in browser" })
    vim.keymap.set("n", "r", function()
        do_reply()
    end, { buffer = buf, nowait = true, desc = "Reply to thread" })
    vim.keymap.set("n", "s", function()
        local actions = {
            { key = "active", txt = "Reopen (active)" },
            { key = "closed", txt = "Resolve (closed)" },
            { key = "fixed", txt = "Mark fixed" },
            { key = "wontfix", txt = "Mark wontfix" },
            { key = "bydesign", txt = "Mark bydesign" },
            { key = "pending", txt = "Mark pending" },
        }
        choose(actions, function(a)
            return a.txt
        end, function(a)
            local ok3, err = pcall(Api.update_thread_status, pr_number, thread.id, a.key)
            if ok3 then
                vim.notify(string.format("Thread #%s -> %s", thread.id, a.key))
            else
                vim.notify(err, vim.log.levels.ERROR)
            end
        end, string.format("Thread #%s — set status", thread.id))
    end, { buffer = buf, nowait = true, desc = "Change status" })
end

open_thread_sidebar = function(pr_id, items, refresh_fn)
    local buf = vim.api.nvim_create_buf(false, true)
    local cur_win = vim.api.nvim_get_current_win()
    vim.cmd("botright split")
    local win = vim.api.nvim_get_current_win()
    local height = math.max(12, math.floor(vim.o.lines * 0.35))
    vim.api.nvim_win_set_height(win, height)
    vim.api.nvim_set_current_win(win)
    vim.api.nvim_win_set_buf(win, buf)
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false
    vim.bo[buf].filetype = "adoThreads"

    local header_lines = 2

    local function hl_line(lnum, hl)
        vim.api.nvim_buf_add_highlight(buf, -1, hl, lnum, 0, -1)
    end

    local function render_lines(current_items)
        local width = vim.api.nvim_win_get_width(win) - 2
        local divider = string.rep("─", math.max(10, width))
        local lines = { string.format("PR !%s threads (%s)", pr_id, UI._threads_filter), divider }
        local highlights = {}
        if #current_items == 0 then
            lines[#lines + 1] = "(no threads match filter)"
            highlights[#highlights + 1] = { #lines - 1, "Comment" }
        else
            for _, it in ipairs(current_items) do
                local line_info = it.line and (":" .. tostring(it.line)) or ""
                local preview = it.preview or ""
                local file_display
                if it.file == "(general)" then
                    file_display = it.file
                else
                    local path = it.file:gsub("^/", "")
                    local parts = {}
                    for part in path:gmatch("[^/]+") do
                        parts[#parts + 1] = part
                    end
                    if #parts <= 3 then
                        file_display = path .. line_info
                    else
                        file_display = table.concat(parts, "/", #parts - 2, #parts) .. line_info
                    end
                end
                lines[#lines + 1] = string.format(
                    "#%-5s %-9s %-40s %s",
                    tostring(it.id),
                    tostring(it.status),
                    file_display:sub(1, 40),
                    preview
                )
                local hl
                if it.status == "active" then
                    hl = "DiagnosticWarn"
                elseif it.status == "pending" then
                    hl = "DiagnosticInfo"
                elseif it.status == "closed" or it.status == "fixed" then
                    hl = "DiagnosticOk"
                else
                    hl = "Normal"
                end
                highlights[#highlights + 1] = { #lines - 1, hl }
            end
        end
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        for _, entry in ipairs(highlights) do
            hl_line(entry[1], entry[2])
        end
        hl_line(0, "Title")
        hl_line(1, "Comment")
    end

    local state = {
        pr_id = pr_id,
        items = items,
        header_lines = header_lines,
        refresh = refresh_fn,
    }
    vim.b[buf].ado_thread_state = state
    render_lines(items)

    local function get_current_item()
        local row = vim.api.nvim_win_get_cursor(win)[1]
        local idx = row - state.header_lines
        if not state.items or idx < 1 or idx > #state.items then
            return nil
        end
        return state.items[idx]
    end

    local function do_refresh()
        if not state.refresh then
            return
        end
        local ok, data = state.refresh()
        if not ok then
            return
        end
        local new_items = build_thread_items(data)
        state.items = new_items
        render_lines(new_items)
    end

    local function do_view()
        local it = get_current_item()
        if not it then
            return
        end
        render_thread_in_editor(pr_id, it._raw, {
            on_reply = function(thread)
                open_reply_editor(pr_id, thread)
            end,
        })
    end

    local function do_reply()
        local it = get_current_item()
        if not it then
            return
        end
        open_reply_editor(pr_id, it._raw)
    end

    local function do_status()
        local it = get_current_item()
        if not it then
            return
        end
        local actions = {
            { key = "active", txt = "Reopen (active)" },
            { key = "closed", txt = "Resolve (closed)" },
            { key = "fixed", txt = "Mark fixed" },
            { key = "wontfix", txt = "Mark wontfix" },
            { key = "bydesign", txt = "Mark bydesign" },
            { key = "pending", txt = "Mark pending" },
        }
        vim.ui.select(actions, {
            prompt = string.format("Thread #%s status", it.id),
            format_item = function(a)
                return a.txt
            end,
        }, function(choice)
            if not choice then
                return
            end
            local ok, err = pcall(Api.update_thread_status, pr_id, it.id, choice.key)
            if ok then
                vim.notify(string.format("Thread #%s -> %s", it.id, choice.key))
                do_refresh()
            else
                vim.notify(err, vim.log.levels.ERROR)
            end
        end)
    end

    local function cycle_filter()
        if UI._threads_filter == "all" then
            UI._threads_filter = "active"
        elseif UI._threads_filter == "active" then
            UI._threads_filter = "unresolved"
        else
            UI._threads_filter = "all"
        end
        do_refresh()
    end

    local function show_help()
        local help_buf = vim.api.nvim_create_buf(false, true)
        local lines = {
            "Threads sidebar keys:",
            "  <CR>/v  View thread in floating window",
            "  r       Reply via markdown buffer",
            "  s       Change thread status",
            "  o       Open PR in browser",
            "  f       Cycle filter (all/active/unresolved)",
            "  R       Refresh threads",
            "  q       Close sidebar",
            "  g?      Show this help",
        }
        vim.api.nvim_buf_set_lines(help_buf, 0, -1, false, lines)
        vim.bo[help_buf].buftype = "nofile"
        vim.bo[help_buf].bufhidden = "wipe"
        vim.bo[help_buf].modifiable = false
        local width = 50
        local height = #lines + 2
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)
        local help_win = vim.api.nvim_open_win(help_buf, true, {
            relative = "editor",
            border = "rounded",
            style = "minimal",
            row = row,
            col = col,
            width = width,
            height = height,
            title = "Azure DevOps Threads Help",
            title_pos = "center",
        })
        vim.keymap.set("n", "q", function()
            pcall(vim.api.nvim_win_close, help_win, true)
        end, { buffer = help_buf, nowait = true })
    end

    vim.keymap.set("n", "<CR>", do_view, { buffer = buf, nowait = true })
    vim.keymap.set("n", "v", do_view, { buffer = buf, nowait = true })
    vim.keymap.set("n", "r", do_reply, { buffer = buf, nowait = true })
    vim.keymap.set("n", "o", function()
        local it = get_current_item()
        if not it then
            return
        end
        local pr_url = string.format(
            "https://dev.azure.com/%s/%s/_git/%s/pullrequest/%s",
            Init.cfg.org,
            Init.cfg.project,
            Init.cfg.repo,
            pr_id
        )
        open_url(pr_url)
    end, { buffer = buf, nowait = true })
    vim.keymap.set("n", "s", do_status, { buffer = buf, nowait = true })
    vim.keymap.set("n", "f", cycle_filter, { buffer = buf, nowait = true })
    vim.keymap.set("n", "R", do_refresh, { buffer = buf, nowait = true })
    vim.keymap.set("n", "g?", show_help, { buffer = buf, nowait = true })
    vim.keymap.set("n", "q", function()
        pcall(vim.api.nvim_win_close, win, true)
    end, { buffer = buf, nowait = true })
end

local function submit_comment_from_buffer(bufnr)
    local ok_ctx, ctx = pcall(vim.api.nvim_buf_get_var, bufnr, "ado_comment_ctx")
    if not ok_ctx then
        vim.notify("Azure DevOps: missing comment context", vim.log.levels.ERROR)
        return
    end
    local ok_off, offset = pcall(vim.api.nvim_buf_get_var, bufnr, "ado_comment_body_start")
    if not ok_off then
        vim.notify("Azure DevOps: missing comment template markers", vim.log.levels.ERROR)
        return
    end
    local lines = vim.api.nvim_buf_get_lines(bufnr, offset, -1, false)
    local body = vim.trim(table.concat(lines, "\n"))
    if body == "" then
        vim.notify("Azure DevOps: comment text is empty", vim.log.levels.WARN)
        return
    end
    local updating = (ctx.comment_id ~= nil and ctx.thread_id ~= nil)
    local replying = (ctx.reply and ctx.thread_id and not ctx.comment_id)
    local ok, res
    if updating then
        ok, res = pcall(Api.update_pr_comment, ctx.pr_id, ctx.thread_id, ctx.comment_id, body)
    elseif replying then
        ok, res = pcall(Api.reply_pr_thread, ctx.pr_id, ctx.thread_id, body)
        if ok and type(res) == "table" then
            ctx.comment_id = res.id or res.commentId or ctx.comment_id
            ctx.reply = false
        end
    else
        if ctx.kind == "selection" then
            ok, res = pcall(
                Api.create_pr_selection_comment,
                ctx.pr_id,
                ctx.file_rel,
                ctx.sline,
                ctx.scol,
                ctx.eline,
                ctx.ecol,
                body,
                { side = ctx.side }
            )
        else
            ok, res = pcall(
                Api.create_pr_line_comment,
                ctx.pr_id,
                ctx.file_rel,
                ctx.line,
                body,
                { side = ctx.side }
            )
        end
        if ok and type(res) == "table" then
            ctx.thread_id = res.id
                or (res._links and res._links.thread and res._links.thread.id)
                or ctx.thread_id
            if res.comments and #res.comments > 0 then
                ctx.comment_id = res.comments[#res.comments].id or ctx.comment_id
            end
        end
    end
    if ok then
        local action = updating and "updated" or (replying and "replied" or "posted")
        vim.bo[bufnr].modified = false
        vim.notify(
            string.format("Azure DevOps: comment %s on !%s %s", action, ctx.pr_id, ctx.range_label)
        )
        vim.api.nvim_buf_set_var(bufnr, "ado_comment_ctx", ctx)
        vim.api.nvim_exec_autocmds("BufWritePost", { buffer = bufnr })
    else
        vim.notify(res, vim.log.levels.ERROR)
    end
end

open_comment_buffer = function(ctx)
    vim.cmd("new")
    local buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].buftype = "acwrite"
    vim.bo[buf].swapfile = false
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].filetype = "markdown"
    vim.bo[buf].modifiable = true
    local safe_name =
        string.format("ado://comment/%s/%s/%s", ctx.pr_id, ctx.file_rel:gsub("/", "_"), ctx.side)
    pcall(vim.api.nvim_buf_set_name, buf, safe_name)

    local header = {
        string.format("# Azure DevOps PR !%s", ctx.pr_id),
        string.format("File: %s", ctx.file_rel),
        string.format("Range: %s", ctx.range_label),
        string.format("Side: %s", ctx.side),
    }
    if ctx.suggestion then
        header[#header + 1] = "Type: suggestion"
    end
    if ctx.thread_id then
        if ctx.comment_id then
            header[#header + 1] =
                string.format("Editing comment #%s in thread #%s", ctx.comment_id, ctx.thread_id)
        elseif ctx.reply then
            header[#header + 1] = string.format("Replying to thread #%s", ctx.thread_id)
        else
            header[#header + 1] = string.format("Thread #%s", ctx.thread_id)
        end
    end
    if ctx.context_lines and #ctx.context_lines > 0 then
        header[#header + 1] = ""
        header[#header + 1] = "```"
        for _, line in ipairs(ctx.context_lines) do
            header[#header + 1] = line
        end
        header[#header + 1] = "```"
    end
    if ctx.thread_comments and #ctx.thread_comments > 0 then
        header[#header + 1] = ""
        header[#header + 1] = "Thread conversation:"
        header[#header + 1] = "```"
        for _, line in ipairs(ctx.thread_comments) do
            header[#header + 1] = line
        end
        header[#header + 1] = "```"
    end
    header[#header + 1] = ""
    header[#header + 1] = "---"
    header[#header + 1] = "Edit below. Save (:w) to submit this comment."
    header[#header + 1] = ""

    local body_start = #header
    local default_text = (ctx.default_text and ctx.default_text ~= "")
            and vim.split(ctx.default_text, "\n", { plain = true })
        or { "" }
    local lines = vim.deepcopy(header)
    vim.list_extend(lines, default_text)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_var(buf, "ado_comment_ctx", ctx)
    vim.api.nvim_buf_set_var(buf, "ado_comment_body_start", body_start)

    vim.api.nvim_create_autocmd("BufWriteCmd", {
        buffer = buf,
        callback = function(ev)
            submit_comment_from_buffer(ev.buf)
        end,
    })
end

-- generic chooser that prefers Snacks -> Telescope -> builtin
local function choose(items, format, on_pick, title)
    format = format or function(x)
        return tostring(x)
    end
    if has_snacks() then
        local disps = {}
        for i, it in ipairs(items) do
            disps[i] = { _ = it, text = format(it) }
        end
        vim.ui.select(disps, {
            prompt = title or "azure-devops.nvim",
            format_item = function(it)
                return it.text
            end,
        }, function(sel)
            if sel then
                on_pick(sel._)
            end
        end)
        return
    end
    if has_telescope() then
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        pickers
            .new({}, {
                prompt_title = title or "azure-devops.nvim",
                finder = finders.new_table({
                    results = items,
                    entry_maker = function(it)
                        local txt = format(it)
                        return { value = it, display = txt, ordinal = txt }
                    end,
                }),
                sorter = conf.generic_sorter({}),
                attach_mappings = function(prompt_bufnr, map)
                    local function select()
                        local selection = action_state.get_selected_entry().value
                        actions.close(prompt_bufnr)
                        on_pick(selection)
                    end
                    map("i", "<CR>", select)
                    map("n", "<CR>", select)
                    return true
                end,
            })
            :find()
        return
    end
    local lines = { title or "azure-devops.nvim" }
    for _, it in ipairs(items) do
        lines[#lines + 1] = format(it)
    end
    simple_picker(lines, function(ln)
        local idx = ln - 1
        if idx >= 1 and items[idx] then
            on_pick(items[idx])
        end
    end, title)
end

-- convenience: prompt for PR id, default to current-branch PR if not provided
local function prompt_pr_id_or_branch(cb, provided_id)
    if provided_id then
        return cb(provided_id)
    end
    local br = current_branch()
    if br then
        local pr = Api.find_pr_by_branch(br)
        if pr and pr.pullRequestId then
            return cb(pr.pullRequestId)
        end
    end
    local data = Api.list_prs("active")
    local prs = {}
    for _, pr in ipairs(data.value or {}) do
        prs[#prs + 1] = {
            id = pr.pullRequestId,
            text = string.format("!%d %s", pr.pullRequestId, pr.title or ""),
        }
    end
    choose(prs, function(p)
        return p.text
    end, function(sel)
        cb(sel.id)
    end, "Select PR")
end

function UI.pick_prs(state)
    local data = Api.list_prs(state)
    local items = {}
    for _, pr in ipairs(data.value or {}) do
        items[#items + 1] = {
            id = pr.pullRequestId,
            key = string.format("!%d", pr.pullRequestId),
            title = pr.title or "(no title)",
            by = (pr.createdBy and pr.createdBy.displayName) or "",
            url = pr._links and pr._links.web and pr._links.web.href or nil,
            status = pr.status,
        }
    end

    choose(items, function(it)
        return string.format("%s  %s  %s", pad(it.key, 8), pad(it.by, 24), it.title)
    end, function(sel)
        if sel.url then
            open_url(sel.url)
        end
    end, "Azure DevOps — Pull Requests")
end

function UI.pick_pipelines()
    local data = Api.list_pipelines()
    local pipelines = {}
    for _, p in ipairs(data.value or {}) do
        pipelines[#pipelines + 1] = {
            id = p.id,
            name = p.name,
            url = p._links and p._links.web and p._links.web.href or nil,
        }
    end

    local function run_selected(p)
        vim.ui.input({
            prompt = string.format(
                "Branch to run %s on (default %s): ",
                p.name,
                Init.cfg.default_branch
            ),
        }, function(branch)
            local ok, res = pcall(Api.run_pipeline, p.id, branch ~= "" and branch or nil)
            if not ok then
                vim.notify(res, vim.log.levels.ERROR)
                return
            end
            local run_url = res._links and res._links.web and res._links.web.href or nil
            vim.notify("Triggered pipeline #" .. p.id .. (run_url and "; opening run..." or ""))
            if run_url then
                open_url(run_url)
            end
        end)
    end

    choose(pipelines, function(p)
        return string.format("%s  %s", pad("#" .. p.id, 8), p.name)
    end, function(sel)
        run_selected(sel)
    end, "Azure DevOps — Pipelines")
end

function UI.pick_builds()
    local data = Api.list_builds(50)
    local items = {}
    for _, b in ipairs(data.value or {}) do
        local def = (b.definition and b.definition.name) or "(definition)"
        local res = (b.result or b.status or "")
        items[#items + 1] = {
            id = b.id,
            name = def,
            result = res,
            url = b._links and b._links.web and b._links.web.href or nil,
        }
    end

    choose(items, function(b)
        return string.format("%s  %-10s  %s", pad("#" .. b.id, 8), b.result, b.name)
    end, function(sel)
        if sel.url then
            open_url(sel.url)
        end
    end, "Azure DevOps — Builds")
end

function UI.show_detect()
    local cfg = require("ado").cfg
    vim.notify(
        string.format(
            "Azure DevOps: org=%s project=%s repo=%s",
            tostring(cfg.org),
            tostring(cfg.project),
            tostring(cfg.repo)
        )
    )
end

function UI.pr_threads(pr_id, filter)
    UI._threads_filter = filter or UI._threads_filter or "all"

    prompt_pr_id_or_branch(function(id)
        local function fetch_threads()
            local ok, data = pcall(Api.list_pr_threads, id)
            if not ok then
                vim.notify("Failed to fetch PR threads: " .. tostring(data), vim.log.levels.ERROR)
                return false
            end
            return true, data
        end

        local ok, data = fetch_threads()
        if not ok then
            return
        end
        local items = build_thread_items(data)
        open_thread_sidebar(id, items, function()
            local rok, rdata = fetch_threads()
            if not rok then
                return false
            end
            return true, rdata
        end)
    end, pr_id)
end

function UI.pr_show_thread(pr_id, thread_id)
    if not thread_id then
        return vim.notify("AdoPRShowThread: require a thread id", vim.log.levels.WARN)
    end
    return (function()
        -- reuse the same PR id resolution helper
        local br = (function()
            local out = vim.fn.systemlist({ "git", "rev-parse", "--abbrev-ref", "HEAD" })[1]
            return (out and out ~= "" and out) or nil
        end)()
        if pr_id then
            local ok, data = pcall(Api.list_pr_threads, pr_id)
            if not ok then
                return vim.notify(
                    "Failed to fetch PR threads: " .. tostring(data),
                    vim.log.levels.ERROR
                )
            end
            for _, t in ipairs(data.value or {}) do
                if tonumber(t.id) == tonumber(thread_id) then
                    return render_thread_in_editor(pr_id, t, {
                        on_reply = function(thread)
                            open_reply_editor(pr_id, thread)
                        end,
                    })
                end
            end
            return vim.notify(
                string.format("Thread #%s not found on !%s", tostring(thread_id), tostring(pr_id)),
                vim.log.levels.WARN
            )
        elseif br then
            local pr = Api.find_pr_by_branch(br)
            if pr and pr.pullRequestId then
                -- fetch and render
                local data = Api.list_pr_threads(pr.pullRequestId)
                for _, t in ipairs(data.value or {}) do
                    if tonumber(t.id) == tonumber(thread_id) then
                        return render_thread_in_editor(pr.pullRequestId, t, {
                            on_reply = function(thread)
                                open_reply_editor(pr.pullRequestId, thread)
                            end,
                        })
                    end
                end
                return vim.notify(
                    string.format(
                        "Thread #%s not found on !%s",
                        tostring(thread_id),
                        tostring(pr.pullRequestId)
                    ),
                    vim.log.levels.WARN
                )
            else
                return vim.notify(
                    "AdoPRShowThread: no PR found for current branch",
                    vim.log.levels.ERROR
                )
            end
        else
            return vim.notify("AdoPRShowThread: not on a git branch", vim.log.levels.ERROR)
        end
    end)()
end

function UI.pr_edit_comment(pr_id, thread_id, comment_id)
    if not thread_id then
        return vim.notify(
            "Azure DevOps: provide a thread id (:AdoPREditComment <thread_id>)",
            vim.log.levels.WARN
        )
    end
    prompt_pr_id_or_branch(function(id)
        local data = Api.list_pr_threads(id)
        local thread = find_thread_by_id(data.value, thread_id)
        if not thread then
            vim.notify(
                string.format(
                    "Azure DevOps: thread #%s not found on !%s",
                    tostring(thread_id),
                    tostring(id)
                ),
                vim.log.levels.ERROR
            )
            return
        end
        local target_comment
        if comment_id then
            for _, c in ipairs(thread.comments or {}) do
                if tonumber(c.id) == tonumber(comment_id) then
                    target_comment = c
                    break
                end
            end
            if not target_comment then
                vim.notify(
                    string.format(
                        "Azure DevOps: comment #%s not found in thread #%s",
                        tostring(comment_id),
                        tostring(thread_id)
                    ),
                    vim.log.levels.ERROR
                )
                return
            end
        else
            local comments = thread.comments or {}
            target_comment = comments[#comments]
            if not target_comment then
                vim.notify(
                    string.format(
                        "Azure DevOps: thread #%s has no comments to edit",
                        tostring(thread_id)
                    ),
                    vim.log.levels.WARN
                )
                return
            end
        end

        local file_rel = thread_file_path(thread) or "(general)"
        local line = thread_line_hint(thread)
        local label
        if file_rel == "(general)" then
            label = string.format("Thread #%s", thread.id)
        else
            label = line and string.format("%s:%s", file_rel, line) or file_rel
        end
        local ctx = {
            pr_id = id,
            file_rel = file_rel,
            range_label = label,
            side = "right",
            thread_id = thread.id,
            comment_id = target_comment.id,
            default_text = target_comment.content or "",
            context_lines = read_file_context(file_rel, line, 2),
        }
        ctx.kind = "edit"
        open_comment_buffer(ctx)
    end, pr_id)
end

function UI.pr_comment(pr_id, opts)
    opts = opts or {}
    prompt_pr_id_or_branch(function(id)
        local ctx = build_comment_context(id, opts)
        if not ctx then
            return
        end
        select_comment_side(opts.side, function(side)
            if not side then
                return
            end
            ctx.side = side
            open_comment_buffer(ctx)
        end)
    end, pr_id)
end

local vote_map = {
    approve = 10,
    approve_suggestions = 5,
    wait = -5,
    reject = -10,
    none = 0,
}

function UI.pr_vote(pr_id)
    prompt_pr_id_or_branch(function(id)
        local opts = {
            { key = "approve", txt = "Approve" },
            { key = "approve_suggestions", txt = "Approve with Suggestions" },
            { key = "wait", txt = "Wait for Author" },
            { key = "reject", txt = "Reject" },
            { key = "none", txt = "Remove Vote" },
        }
        choose(opts, function(o)
            return o.txt
        end, function(sel)
            local v = vote_map[sel.key]
            local ok, err = pcall(Api.set_vote, id, v)
            if ok then
                vim.notify("Set vote on PR !" .. id .. " to " .. sel.txt)
            else
                vim.notify(err, vim.log.levels.ERROR)
            end
        end, "Set Vote !" .. id)
    end, pr_id)
end

function UI.pr_resolve(pr_id, new_status)
    new_status = new_status or "closed"
    prompt_pr_id_or_branch(function(id)
        local data = Api.list_pr_threads(id)
        local items = {}
        for _, t in ipairs(data.value or {}) do
            items[#items + 1] = {
                id = t.id,
                status = t.status or "active",
                file = t.threadContext and t.threadContext.filePath or "(general)",
            }
        end
        choose(items, function(x)
            return string.format("#%s %-8s %s", x.id, x.status, x.file)
        end, function(sel)
            local ok, err = pcall(Api.update_thread_status, id, sel.id, new_status)
            if ok then
                vim.notify(string.format("Thread #%s -> %s", sel.id, new_status))
            else
                vim.notify(err, vim.log.levels.ERROR)
            end
        end, (new_status == "active" and "Reopen" or "Resolve") .. " Thread !" .. id)
    end, pr_id)
end

return UI
