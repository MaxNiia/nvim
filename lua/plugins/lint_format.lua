return {
    {
        'mfussenegger/nvim-lint',
        dependencies = { "williamboman/mason.nvim" },
        event = "BufReadPre",
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                -- NOTE: YAML
                yaml = { "yamllint", },

                -- NOTE: JS/TS
                css = { "stylelint" },
                javascript = { "eslint" },
                javascriptreact = { "stylelint", "eslint_d" },
                typescript = { "eslint" },
                typescriptreact = { "stylelint", "eslint_d" },

                -- NOTE: shellcheck
                bash = { "shellcheck", },
                zsh = { "shellcheck" },
                sh = { "shellcheck" },

                python = {
                    "flake8",
                    "mypy",
                    "pydocstyle",
                    "pylint",
                },
                markdown = { "markdownlint" },
                lua = {
                    "luacheck",
                },
                json = {
                    "jsonlint",
                },
                cmake = {
                    "cmakelint",
                },
                protobuf = { "buf_lint" },
                bazel = { "buildifier", },

                dockerfile = { "hadolint", },

            }
            local function debounce(ms, fn)
                local timer = vim.loop.new_timer()
                return function(...)
                    local argv = { ... }
                    timer:start(ms, 0, function()
                        timer:stop()
                        vim.schedule_wrap(fn)(unpack(argv))
                    end)
                end
            end

            local function lint_fnc()
                lint.try_lint()
                lint.try_lint({ "editorconfig-checker" })
            end

            vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
                group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
                callback = debounce(100, lint_fnc),
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            ensure_installed = {
                -- NOTE: LSP
                "clangd",
                "lua-language-server",
                "pyright",
                "cmakelang",

                -- NOTE: LINT
                "cspell",
                "stylelint",
                "cmakelint",
                "buildifier",
                "buf",
                "eslint_d",
                "editorconfig-checker",
                "flake8",
                "hadolint",
                "jsonlint",
                "luacheck",
                "markdownlint",
                "mypy",
                "pydocstyle",
                "pylint",
                "shellcheck",
                "yamllint",
            },
            pip = {
                upgrade_pip = true,
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },
}