return {
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            ensure_installed = {
                "beutysh",
                "buf",
                "cmake_format",
                "cmake_lint",
                "commitlint",
                "cpell",
                "eslint_d",
                "gitlint",
                "gitrebase",
                "hadolint",
                "jsonlint",
                "luasnip",
                "markdownlint",
                "zsh",
            },
            automatic_setup = true,
        },
        config = function(_, opts)
            local null_ls = require("null-ls")

            opts.handlers = {
                function(source_name, methods)
                    require("mason-null-ls.automatic_setup")(source_name, methods)
                end,
                cmake_format = function(_, _)
                    null_ls.register(null_ls.builtins.formatting.cmake_format)
                end,
                eslint_d = function(_, _)
                    null_ls.register(null_ls.builtins.code_actions.eslint_d)
                    null_ls.register(null_ls.builtins.diagnostics.eslint_d)
                    null_ls.register(null_ls.builtins.formatting.eslint_d)
                end,
                buf = function(_, _)
                    null_ls.register(null_ls.builtins.diagnostics.buf)
                    null_ls.register(null_ls.builtins.formatting.buf)
                end,
                commitlint = function(_, _)
                    null_ls.register(null_ls.builtins.diagnostics.commitlint)
                end,
                hadolint = function(_, _)
                    null_ls.register(null_ls.builtins.diagnostics.hadolint)
                end,
                jsonlint = function(_, _)
                    null_ls.register(null_ls.builtins.diagnostics.jsonlint)
                end,
                markdownlint = function(_, _)
                    null_ls.register(null_ls.builtins.diagnostics.markdownlint)
                    null_ls.register(null_ls.builtins.formatting.markdownlint)
                end,
                zsh = function(_, _)
                    null_ls.register(null_ls.builtins.diagnostics.zsh)
                end,
                beutysh = function(_, _)
                    null_ls.register(null_ls.builtins.formatting.beautysh)
                end,
                typescript = function(_, _)
                    null_ls.register(require("typescript.extenstions.null-ls.code-actions"))
                end,
                -- black = function(_, _)
                --     null_ls.register(null_ls.builtins.formatting.black)
                -- end,
            }

            require("mason-null-ls").setup(opts)

            null_ls.setup({
                sources = {
                    null_ls.builtins.code_actions.gitrebase,
                    null_ls.builtins.diagnostics.gitlint,

                    -- Refactoring
                    null_ls.builtins.code_actions.refactoring,

                    -- Typescript
                    null_ls.builtins.code_actions.ts_node_action,

                    -- Luasnip
                    null_ls.builtins.completion.luasnip,

                    -- CMAKE
                    null_ls.builtins.diagnostics.cmake_lint,

                    -- Dotenv
                    null_ls.builtins.diagnostics.dotenv_linter,

                    -- ZSH
                    null_ls.builtins.diagnostics.zsh,
                },
            })
        end,
    },
}
