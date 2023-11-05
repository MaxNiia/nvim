return {
    {
        "mfussenegger/nvim-lint",
        dependencies = { "williamboman/mason.nvim" },
        event = "BufReadPre",
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                -- NOTE: YAML
                yaml = { "yamllint" },

                -- NOTE: JS/TS
                css = { "stylelint" },
                javascript = { "eslint" },
                javascriptreact = { "stylelint", "eslint_d" },
                typescript = { "eslint" },
                typescriptreact = { "stylelint", "eslint_d" },

                -- NOTE: shellcheck
                bash = { "shellcheck" },
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
                bazel = { "buildifier" },

                dockerfile = { "hadolint" },
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
            end

            vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
                group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
                callback = debounce(100, lint_fnc),
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
            vim.api.nvim_create_user_command("FormatDisable", function(args)
                if args.bang then
                    -- FormatDisable! will disable formatting just for this buffer
                    vim.b.disable_autoformat = true
                else
                    vim.g.disable_autoformat = true
                end
            end, {
                desc = "Disable autoformat-on-save",
                bang = true,
            })
            vim.api.nvim_create_user_command("FormatEnable", function()
                vim.b.disable_autoformat = false
                vim.g.disable_autoformat = false
            end, {
                desc = "Re-enable autoformat-on-save",
            })
        end,
        opts = {
            format_on_save = nil,
            format_after_save = function(bufnr)
                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_fallback = true, async = true }
            end,
            formatters_by_ft = {
                lua = { "stylua" },
                bash = { "beautysh", "shfmt" },
                python = { "isort", "black", "autoflake", "autopep8" },
                css = { "stylelint" },
                javascript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
                javascriptreact = {
                    "stylelint",
                    { "prettierd", "prettier" },
                    { "eslint_d", "eslint" },
                },
                typescript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
                typescriptreact = {
                    "stylelint",
                    { "prettierd", "prettier" },
                    { "eslint_d", "eslint" },
                },
                json = { "fixjson" },
                yaml = { "yamlfmt" },
                markdown = { "markdownlint" },
            },
        },
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

                -- NOTE: FORMAT
                "yamlfmt",
                "fixjson",
                "stylua",
                "beautysh",
                "isort",
                "black",
                "autoflake",
                "autopep8",
                "prettierd",
                "prettier",
                "shfmt",
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
