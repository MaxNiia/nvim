local opts = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        {
            ".luarc.json",
            ".luacheckrc",
            ".stylua.toml",
            "stylua.toml",
            "selene.toml",
            "selene.yml",
        },
        ".git",
    },
    settings = {
        Lua = {
            format = {
                indent_size = "4",
                indent_style = "space",
                quote_style = "double",
                call_arg_parentheses = "always",
                trailing_table_separator = "always",
                align_call_args = true,
                align_function_params = true,
                align_continuous_assign_statement = false,
                align_continuous_rect_table_field = false,
                align_if_branch = false,
                align_array_table = false,
            },
            hint = {
                enable = true,
            },
            codeLens = {
                enable = true,
            },
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
            workspace = {
                checkThirdParty = false,
                -- library = vim.api.nvim_get_runtime_file("", true),
            },
        },
    },
    capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true,
                },
            },
        },
    },
    docs = {
        description = [[
https://github.com/LuaLS/lua-language-server

Install:
Symlink a release version.
]],
    },
}

opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities, require("lsp").capabilities)

return opts
