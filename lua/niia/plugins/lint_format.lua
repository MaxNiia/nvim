return {
    {
        "mfussenegger/nvim-lint",
        event = "BufReadPre",
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                ["*"] = {},
                -- NOTE: YAML
                yaml = { "yamllint" },

                -- NOTE: shellcheck
                bash = { "shellcheck" },
                sh = { "shellcheck" },

                python = {},
                markdown = { "markdownlint" },
                lua = {},
                json = {
                    "jsonlint",
                },
                protobuf = { "buf_lint" },
                bzl = { "buildifier" },

                dockerfile = { "hadolint" },
                zsh = { "zsh", "shellcheck" },
            }
            local function debounce(ms, fn)
                local timer = vim.uv.new_timer()
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
        event = "BufEnter",
        init = function()
            vim.g.autoformat = true
            vim.b.autoformat = true
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

            vim.api.nvim_create_user_command("FormatDisable", function(args)
                if args.bang then
                    -- FormatDisable! will disable formatting just for this buffer
                    vim.b.autoformat = false
                else
                    vim.g.autoformat = false
                end
            end, {
                desc = "Disable autoformat-on-save",
                bang = true,
            })
            vim.api.nvim_create_user_command("FormatEnable", function(args)
                if args.bang then
                    -- FormatEnable! will enable formatting just for this buffer
                    vim.b.autoformat = true
                else
                    vim.g.autoformat = true
                end
            end, {
                desc = "Re-enable autoformat-on-save",
                bang = true,
            })
        end,
        opts = {
            format_on_save = nil,
            format_after_save = function(bufnr)
                -- Enable with a global or buffer-local variable
                if vim.g.autoformat or vim.b[bufnr].autoformat then
                    return { timeout_ms = 500, lsp_fallback = true, async = true }
                end
            end,
            formatters_by_ft = {
                ["_"] = { "trim_whitespace" },
                lua = { "stylua" },
                bash = { "beautysh", "shfmt" },
                bzl = { "buildifier" },
                python = { "ruff_format" },
                -- css = { "stylelint" },
                -- javascript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
                -- javascriptreact = {
                --     "stylelint",
                --     { "prettierd", "prettier" },
                --     { "eslint_d", "eslint" },
                -- },
                -- typescript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
                -- typescriptreact = {
                --     "stylelint",
                --     { "prettierd", "prettier" },
                --     { "eslint_d", "eslint" },
                -- },
                json = { "fixjson" },
                -- yaml = { "yamlfmt" },
                markdown = { "markdownlint" },
                cpp = { "clang-format" },
            },
        },
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            ensure_installed = {
                -- NOTE: DAP
                "cpptools",

                -- NOTE: LSP
                "ast-grep",
                "basedpyright",
                "clangd",
                "lua-language-server",
                "ruff",
                "marksman",
                "bzl",

                -- NOTE: LINT
                "buf",
                "buildifier",
                "eslint_d",
                "hadolint",
                "jsonlint",
                "luacheck",
                "markdownlint",
                "ruff",
                "shellcheck",
                "stylelint",
                "yamllint",

                -- NOTE: FORMAT
                "autoflake",
                "clang-format",
                "autopep8",
                "beautysh",
                "fixjson",
                "prettier",
                "prettierd",
                "shfmt",
                "stylua",
                -- "yamlfmt",
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
