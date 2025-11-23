local M = {}

-- Helper to format call hierarchy items for picker
local function format_call_item(item)
    local uri = item.uri or item.from.uri
    local range = item.range or item.from.range
    local name = item.name or item.from.name

    local file = vim.uri_to_fname(uri)
    local line = range.start.line + 1

    return string.format("%s:%d - %s", vim.fn.fnamemodify(file, ":~:."), line, name)
end

-- Show incoming calls (who calls this function)
function M.incoming_calls()
    local params = vim.lsp.util.make_position_params()

    vim.lsp.buf_request(0, "textDocument/prepareCallHierarchy", params, function(err, result)
        if err or not result or vim.tbl_isempty(result) then
            vim.notify("No call hierarchy available", vim.log.levels.INFO)
            return
        end

        local item = result[1]
        vim.lsp.buf_request(0, "callHierarchy/incomingCalls", { item = item }, function(err2, calls)
            if err2 or not calls or vim.tbl_isempty(calls) then
                vim.notify("No incoming calls found", vim.log.levels.INFO)
                return
            end

            local items = vim.tbl_map(format_call_item, calls)

            require("snacks").picker.pick({
                prompt = "Incoming Calls",
                items = items,
            }, function(selected, idx)
                if selected then
                    local call = calls[idx]
                    local uri = call.from.uri
                    local range = call.from.range

                    vim.cmd.edit(vim.uri_to_fname(uri))
                    vim.api.nvim_win_set_cursor(0, { range.start.line + 1, range.start.character })
                end
            end)
        end)
    end)
end

-- Show outgoing calls (what this function calls)
function M.outgoing_calls()
    local params = vim.lsp.util.make_position_params()

    vim.lsp.buf_request(0, "textDocument/prepareCallHierarchy", params, function(err, result)
        if err or not result or vim.tbl_isempty(result) then
            vim.notify("No call hierarchy available", vim.log.levels.INFO)
            return
        end

        local item = result[1]
        vim.lsp.buf_request(0, "callHierarchy/outgoingCalls", { item = item }, function(err2, calls)
            if err2 or not calls or vim.tbl_isempty(calls) then
                vim.notify("No outgoing calls found", vim.log.levels.INFO)
                return
            end

            local items = vim.tbl_map(function(call)
                return format_call_item(call.to)
            end, calls)

            require("snacks").picker.pick({
                prompt = "Outgoing Calls",
                items = items,
            }, function(selected, idx)
                if selected then
                    local call = calls[idx]
                    local uri = call.to.uri
                    local range = call.to.range

                    vim.cmd.edit(vim.uri_to_fname(uri))
                    vim.api.nvim_win_set_cursor(0, { range.start.line + 1, range.start.character })
                end
            end)
        end)
    end)
end

return M
