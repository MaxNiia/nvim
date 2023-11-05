local M = {}

M.new_tab = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local action_utils = require("telescope.actions.utils")
    local tab_new = function(prompt_bufnr, _)
        actions.select_default:replace(function()
            local results = {}

            action_utils.map_selections(prompt_bufnr, function(selection)
                results[selection.index] = selection[1]
            end)

            -- Results is empty
            if next(results) == nil then
                results[1] = action_state.get_selected_entry()[1]
            end

            actions.close(prompt_bufnr)
            require("tabline").tab_new(unpack(results))
        end)
        return true
    end
    require("telescope.builtin")["find_files"]({
        cwd = vim.loop.cwd(),
        attach_mappings = tab_new,
    })
end

M.rename_tab = function()
    local tab_rename = require("tabline").tab_rename
    vim.ui.input({ prompt = "New tab name: " }, function(input)
        if input == "" or input == nil then
            return
        end
        tab_rename(input)
    end)
end

M.bind_buffers = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local action_utils = require("telescope.actions.utils")
    local bind_buffers = function(prompt_bufnr, _)
        actions.select_default:replace(function()
            local results = {}

            action_utils.map_selections(prompt_bufnr, function(selection)
                results[selection.index] = selection.value
            end)

            -- Results is empty
            if next(results) == nil then
                results[1] = action_state.get_selected_entry()[1]
            end

            actions.close(prompt_bufnr)
            require("tabline").bind_buffers(unpack(results))
        end)
        return true
    end
    require("telescope.builtin")["buffers"]({
        attach_mappings = bind_buffers,
    })
end

return M
