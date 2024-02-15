return {
    name = "ninja",
    params = {
        build_dir = {
            type = "string",
            name = "Build directory",
            desc = "The build directory to run ninja in",
            order = 1,
            validate = function(path)
                return vim.fn.isdirectory(vim.fn.expand(path))
            end,
            optional = false,
        },
    },
    builder = function(params)
        return {
            cmd = { "ninja" },
            args = { "-C", params.build_dir },
            components = { { "on_output_quickfix", open = true }, "default" },
        }
    end,
    condition = {
        filetype = { "cpp", "c", "cmake" },
    },
}
