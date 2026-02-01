require("overseer").setup()

-- Helper to get tasks (buffer-local or global or empty)
local function get_tasks()
    -- Priority: buffer-local > project-global
    return vim.b.overseer_tasks or vim.g.overseer_tasks or {}
end

-- Helper to run project-specific tasks
local function run_project_task(task_name)
    local overseer = require("overseer")
    local tasks = get_tasks()
    local task_config = tasks[task_name]

    if not task_config then
        vim.notify(
            string.format("Task '%s' not found", task_name),
            vim.log.levels.WARN
        )
        return
    end

    overseer.run_template({
        name = "shell",
        params = {
            cmd = task_config.cmd or task_config,
            cwd = task_config.cwd,
        },
    }, function(task)
        if task then
            overseer.open()
        end
    end)
end

local key = vim.keymap.set

-- Core overseer commands
key("n", "<leader>ot", "<cmd>OverseerToggle<cr>", { desc = "Toggle task list" })
key("n", "<leader>or", "<cmd>OverseerRun<cr>", { desc = "Run task" })
key("n", "<leader>oq", "<cmd>OverseerQuickAction<cr>", { desc = "Quick action" })
key("n", "<leader>oi", "<cmd>OverseerInfo<cr>", { desc = "Overseer info" })
key("n", "<leader>ob", "<cmd>OverseerBuild<cr>", { desc = "Build task" })
key("n", "<leader>oa", "<cmd>OverseerTaskAction<cr>", { desc = "Task action" })
key("n", "<leader>oc", "<cmd>OverseerClearCache<cr>", { desc = "Clear cache" })

-- Run :make (uses buffer's makeprg)
key("n", "<leader>om", function()
    local overseer = require("overseer")
    local makeprg = vim.bo.makeprg
    if makeprg == "" then
        makeprg = "make"
    end
    overseer.run_template({
        name = "shell",
        params = {
            cmd = makeprg,
        },
    }, function(task)
        if task then
            overseer.open()
        end
    end)
end, { desc = "Run makeprg" })

-- Quick build command (prompts for command)
key("n", "<leader>oB", function()
    local overseer = require("overseer")
    overseer.run_template({ name = "shell" }, function(task)
        if task then
            overseer.open()
        end
    end)
end, { desc = "Run shell command" })

-- Re-run last task
key("n", "<leader>ol", function()
    local overseer = require("overseer")
    local tasks = overseer.list_tasks({ recent_first = true })
    if vim.tbl_isempty(tasks) then
        vim.notify("No tasks found", vim.log.levels.WARN)
    else
        overseer.run_action(tasks[1], "restart")
    end
end, { desc = "Re-run last task" })

-- Run project-specific tasks (configure in .nvim.lua or ftplugin)
key("n", "<leader>op", function()
    local tasks = get_tasks()
    if vim.tbl_isempty(tasks) then
        vim.notify("No tasks defined (set vim.b.overseer_tasks or vim.g.overseer_tasks)", vim.log.levels.WARN)
        return
    end

    local task_names = vim.tbl_keys(tasks)
    vim.ui.select(task_names, {
        prompt = "Select task:",
    }, function(choice)
        if choice then
            run_project_task(choice)
        end
    end)
end, { desc = "Run project task" })

--[[
Configure tasks in three ways:

1. Filetype defaults (after/ftplugin/<filetype>.lua):
   vim.b.overseer_tasks = {
     build = "cargo build",
     test = "cargo test",
   }

2. Project-specific in .nvim.lua (with exrc enabled):
   vim.g.overseer_tasks = {
     build = "make -j8",
     test = "make test",
     -- Or with options:
     custom = {
       cmd = "bazel build //...",
       cwd = vim.fn.getcwd(),
     },
   }

3. Use makeprg directly with <leader>om

Priority: vim.b.overseer_tasks > vim.g.overseer_tasks
Then use <leader>op to pick and run, or <leader>om to run makeprg.
]]
