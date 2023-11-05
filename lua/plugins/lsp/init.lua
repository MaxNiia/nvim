return {
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            "MaxNiia/nvim-navbuddy",
            "propet/colorscheme-persist.nvim",
            "folke/neodev.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "onsails/lspkind.nvim",
            "SmiteshP/nvim-navic",
            "mfussenegger/nvim-dap",
            "kevinhwang91/nvim-ufo",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
        },
        keys = {
            {
                "<leader>k",
                vim.diagnostic.open_float,
                desc = "Open float",
            },
            {
                "<leader>j",
                vim.diagnostic.setloclist,
                desc = "Set diagnostic list",
            },
        },
        opts = {
            -- options for vim.diagnostic.config()
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = false, -- Replaces by lsp_lines { spacing = 4, prefix = "●" },
                severity_sort = true,
                virtual_lines = true,
            },
            -- Automatically format on save
            autoformat = true,
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            setup = {},
            servers = require("plugins.lsp.servers"),
        },
        config = function(_, opts)
            require("neodev").setup()
            local lspconfig = require("lspconfig")

            -- diagnostics
            local signs = { Error = "", Warn = "", Hint = "", Info = "" }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, {
                    text = icon,
                    texthl = hl, --[[numhl = hl]]
                })
            end

            vim.diagnostic.config(opts.diagnostics)

            local servers = opts.servers
            local capabilities = require("cmp_nvim_lsp").default_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            )

            -- Specify otherwise clangd seems to use utf-8.
            capabilities.offsetEncoding = { "utf-16" }
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end
                lspconfig[server].setup(server_opts)
            end

            local mlsp = require("mason-lspconfig")
            local available = mlsp.get_available_servers()

            local ensure_installed = {}
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or not vim.tbl_contains(available, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
            require("mason-lspconfig").setup_handlers({ setup })

            -- LspAttach
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    local navic = require("nvim-navic")

                    if client.server_capabilities.documentSymbolProvider then
                        navic.attach(client, bufnr)
                    end

                    -- Enable completion triggered by <c-x><c-o>
                    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                    -- Mappings
                    require("plugins.lsp.keymaps").default(bufnr)
                    if client.server_capabilities.inlayHintProvider then
                        local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
                        require("plugins.lsp.keymaps").inlay_hints(bufnr)
                        inlay_hint(bufnr, true)
                    end

                    if client.name == "clangd" then
                        require("plugins.lsp.keymaps").clangd(bufnr)
                    end
                    -- Normal Mode
                end,
            })

            local function mason_post_install(pkg)
                if pkg.name ~= "python-lsp-server" then
                    return
                end

                local venv = vim.fn.stdpath("data") .. "/mason/packages/python-lsp-server/venv"
                local job = require("plenary.job")

                job:new({
                    command = venv .. "/bin/pip",
                    args = {
                        "install",
                        "-U",
                        "--disable-pip-version-check",
                        "python-lsp-black",
                        "pylsp-mypy",
                        "pyls-isort",
                        "pylsp-rope",
                    },
                    cwd = venv,
                    env = { VIRTUAL_ENV = venv },
                    on_exit = function()
                        if vim.fn.executable(venv .. "/bin/black") == 1 then
                            vim.notify("Finished installing pylsp plugins.")
                            return
                        end
                    end,
                    on_start = function()
                        vim.notify("Installing pylsp plugins...")
                    end,
                    on_stderr = function(_, data)
                        vim.notify(data, vim.log.levels.ERROR)
                    end,
                }):start()
            end

            require("mason-registry"):on("package:install:success", mason_post_install)
        end,
    },
}
