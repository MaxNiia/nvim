local M = {}

-- Pattern definitions for different file types
local patterns = {
    -- C++ patterns
    {
        pattern = "(.+)%.cpp$",
        test_format = "Test%s.cpp",
        impl_format = "%s.cpp",
        search_dirs = {
            ".",
            "../test",
            "../tests",
            "test",
            "tests",
            "../../../test",
            "../../test/src",
        },
    },
    {
        pattern = "(.+)%.cc$",
        test_format = "Test%s.cc",
        impl_format = "%s.cc",
        search_dirs = {
            ".",
            "../test",
            "../tests",
            "test",
            "tests",
            "../../../test",
            "../../test/src",
        },
    },
    {
        pattern = "(.+)%.h$",
        test_format = "Test%s.cpp",
        impl_format = "%s.h",
        search_dirs = {
            ".",
            "../test",
            "../tests",
            "test",
            "tests",
            "../src",
            "src",
            "../../../test",
            "../../test/src",
            "../../../src",
            "../../src",
        },
    },
    {
        pattern = "(.+)%.hpp$",
        test_format = "Test%s.cpp",
        impl_format = "%s.hpp",
        search_dirs = {
            ".",
            "../test",
            "../tests",
            "test",
            "tests",
            "../src",
            "src",
            "../../../test",
            "../../test/src",
            "../../../src",
        },
    },
    -- Python patterns
    {
        pattern = "(.+)%.py$",
        test_format = "test_%s.py",
        impl_format = "%s.py",
        search_dirs = { ".", "../test", "../tests", "test", "tests" },
    },
}

-- Check if file exists in any of the search directories
local function find_file(basename, filename, search_dirs)
    local current_file = vim.fn.expand("%:p")
    local current_dir = vim.fn.fnamemodify(current_file, ":h")

    -- First try: search in configured directories
    for _, dir in ipairs(search_dirs) do
        local full_dir = vim.fn.resolve(current_dir .. "/" .. dir)
        local full_path = full_dir .. "/" .. filename

        if vim.fn.filereadable(full_path) == 1 then
            return full_path
        end
    end

    local path_parts = vim.split(current_file, "/", { plain = true })

    -- Find 'src' or 'test' in path
    local src_idx, test_idx
    for i, part in ipairs(path_parts) do
        if part == "src" then
            src_idx = i
        elseif part == "test" then
            test_idx = i
        end
    end

    if src_idx and not test_idx then
        -- We're in src, look for test
        -- Build path: replace 'src' with 'test/src' and filename is already Test-prefixed
        local new_path = {}
        for i = 1, src_idx - 1 do
            table.insert(new_path, path_parts[i])
        end
        table.insert(new_path, "test")
        table.insert(new_path, "src")
        for i = src_idx + 1, #path_parts - 1 do
            table.insert(new_path, path_parts[i])
        end
        table.insert(new_path, filename)

        local candidate = "/" .. table.concat(new_path, "/")
        if vim.fn.filereadable(candidate) == 1 then
            return candidate
        end
    elseif test_idx then
        -- We're in test, look for src
        -- Build path: remove 'test/' and filename is already without Test prefix
        local new_path = {}
        for i = 1, test_idx - 1 do
            table.insert(new_path, path_parts[i])
        end
        -- Skip 'test', keep everything after it
        for i = test_idx + 1, #path_parts - 1 do
            if path_parts[i] ~= "src" or i ~= test_idx + 1 then
                table.insert(new_path, path_parts[i])
            else
                -- This is the 'src' right after 'test', keep it
                table.insert(new_path, path_parts[i])
            end
        end
        table.insert(new_path, filename)

        local candidate = "/" .. table.concat(new_path, "/")
        if vim.fn.filereadable(candidate) == 1 then
            return candidate
        end
    end

    return nil
end

-- Toggle between test and implementation
function M.toggle()
    local current = vim.fn.expand("%:t")
    local current_path = vim.fn.expand("%:p")

    for _, pattern_config in ipairs(patterns) do
        local base = current:match(pattern_config.pattern)
        if base then
            -- Determine if current file is a test
            local is_test = current:match("^[Tt]est") or current:match("^test_")

            local target_filename
            if is_test then
                -- Remove Test prefix or test_ prefix to get base name
                local impl_base = base:gsub("^[Tt]est", ""):gsub("^test_", "")
                target_filename = string.format(pattern_config.impl_format, impl_base)
            else
                -- Add Test prefix
                target_filename = string.format(pattern_config.test_format, base)
            end

            -- Try to find the file
            local target_path = find_file(base, target_filename, pattern_config.search_dirs)

            if target_path then
                vim.cmd.edit(target_path)
                vim.notify(
                    string.format("Switched to %s", vim.fn.fnamemodify(target_path, ":~:.")),
                    vim.log.levels.INFO
                )
                return
            else
                vim.notify(
                    string.format("File not found: %s", target_filename),
                    vim.log.levels.WARN
                )
                return
            end
        end
    end

    vim.notify("No test/implementation pattern matched for this file", vim.log.levels.WARN)
end

return M
