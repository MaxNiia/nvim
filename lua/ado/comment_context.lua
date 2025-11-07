-- ado/comment_context.lua
local M = {}

-- Convert an absolute path to a repo-relative path with forward slashes.
-- fallback: if already relative, keep as-is.
function M.to_repo_relative(abs_or_rel_path, repo_root)
    local p = abs_or_rel_path
    if repo_root and p:sub(1, #repo_root) == repo_root then
        p = p:sub(#repo_root + 2) -- drop trailing slash; +1 for '/', +1 to start after it
    end
    p = p:gsub("\\", "/")
    if not p:match("^/") then
        p = "/" .. p
    end
    return p
end

-- Build a valid ADO threadContext for a selection or single line comment.
-- side: "right" (default) or "left"
function M.build_thread_context(rel_path, l1, c1_0, l2, c2_0, side)
    side = side or "right"
    local base = {
        filePath = rel_path,
    }
    local start_pos = { line = tonumber(l1), offset = tonumber((c1_0 or 0) + 1) }
    local end_pos = { line = tonumber(l2 or l1), offset = tonumber((c2_0 or c1_0 or 0) + 1) }

    if side == "left" then
        base.leftFileStart = start_pos
        base.leftFileEnd = end_pos
    else
        base.rightFileStart = start_pos
        base.rightFileEnd = end_pos
    end
    return base
end

return M
