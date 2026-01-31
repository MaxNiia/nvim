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
                enable = true,
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
        documentFormattingProvider = false,
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

opts.capabilities = vim.tbl_deep_extend("force", require("capabilities").capabilities, opts.capabilities)

return opts
