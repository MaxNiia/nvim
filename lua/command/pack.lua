local M = {}

-- This is where you implement the behavior of each subcommand.
-- You can replace these bodies with calls into lazy/packer/etc.

function M.update(rest_args)
    vim.pack.update()
end

function M.remove(args)
    vim.pack.del(args)
end

function M.dispatch(opts)
    local args = vim.split(opts.args, "%s+", { trimempty = true })

    local subcmd = args[1] and string.lower(args[1]) or nil
    local rest = vim.list_slice(args, 2)

    if subcmd == "update" then
        M.update(rest)
    elseif subcmd == "remove" or subcmd == "rm" or subcmd == "delete" then
        M.remove(rest)
    else
        print([[
Pack <subcommand> [args...]

Subcommands:
  Update                Update all packs
  Remove <name>         Remove/uninstall a pack
]])
    end
end

function M.complete(ArgLead, CmdLine, CursorPos)
    local parts = vim.split(CmdLine, "%s+")
    local command_match = false
    local sub = parts[2]
    local commands = { "Update", "Remove" }

    for _, command in ipairs(commands) do
        if command == sub then
            command_match = true
            break
        end
    end

    if command_match == false then
        return vim.tbl_filter(function(items)
            return items:find("^" .. vim.pesc(ArgLead))
        end, commands)
    end

    if string.lower(sub) == "remove" then
        local packages = vim.pack.get(nil, { info = false })
        local package_names = {}
        for _, pkg in ipairs(packages) do
            table.insert(package_names, pkg.spec.name)
        end

        return vim.tbl_filter(function(items)
            return items:find("^" .. vim.pesc(ArgLead))
        end, package_names)
    end

    return {}
end

return M
