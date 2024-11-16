return {
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "onsails/lspkind.nvim",
            {
                "artemave/workspace-diagnostics.nvim",
                keys = {
                    {
                        "<leader>Lw",
                        function()
                            local clients = vim.lsp.get_clients()
                            for _, client in ipairs(clients) do
                                if client.name ~= "typos_lsp" then
                                    require("workspace-diagnostics").populate_workspace_diagnostics(
                                        client,
                                        0
                                    )
                                end
                            end
                        end,
                        desc = "Workspace diagnostics",
                    },
                },
            },
            {
                "p00f/clangd_extensions.nvim",
                dependencies = {
                    "mortepau/codicons.nvim",
                },
                lazy = true,
                config = true,
                opts = {
                    ast = {
                        --These require codicons (https://github.com/microsoft/vscode-codicons)
                        role_icons = {
                            type = "",
                            declaration = "",
                            expression = "",
                            specifier = "",
                            statement = "",
                            ["template argument"] = "",
                        },
                        kind_icons = {
                            Compound = "",
                            Recovery = "",
                            TranslationUnit = "",
                            PackExpansion = "",
                            TemplateTypeParm = "",
                            TemplateTemplateParm = "",
                            TemplateParamObject = "",
                        },
                    },
                },
            },
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
                severity_sort = true,
                virtual_text = false,
                --[[
                {
                    spacing = 1,
                    prefix = function(diagnostic)
                        local icons = require("utils.icons").diagnostics
                        for d, icon in pairs(icons) do
                            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                                return " " .. icon
                            end
                        end
                    end,
                    suffix = " ",
                    source = "if_many",
                    virt_text_pos = "eol",
                    virt_text_hide = true,
                },
                ]]
            },
            -- Automatically format on save
            autoformat = true,
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            setup = {},
        },
        config = function(_, opts)
            local ok, wf = pcall(require, "vim.lsp._watchfiles")
            if ok then
                -- disable lsp watcher. Too slow on linux
                wf._watchfunc = function()
                    return function() end
                end
            end

            local servers = require("plugins.lsp.servers")
            local lspconfig = require("lspconfig")

            for type, icon in pairs(require("utils.icons").diagnostics) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, {
                    text = icon,
                    texthl = hl, --[[numhl = hl]]
                })
            end

            vim.diagnostic.config(opts.diagnostics)

            local capabilities = require("cmp_nvim_lsp").default_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            )

            -- Specify otherwise clangd seems to use utf-8.
            capabilities.offsetEncoding = { "utf-16" }
            capabilities.semanticTokensProvider = nil
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

                    if client == nil then
                        return
                    end
                    if client.name == "ast_grep" then
                        return
                    end

                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Mappings
                    require("plugins.lsp.keymaps").default(bufnr)
                    if client.server_capabilities.inlayHintProvider then
                        require("plugins.lsp.keymaps").inlay_hints(bufnr)
                        vim.lsp.inlay_hint.enable(true)
                    end

                    -- -- Codelens
                    -- if client.server_capabilities.codeLensProvider then
                    --     vim.lsp.codelens.refresh()
                    --     vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                    --         buffer = bufnr,
                    --         callback = vim.lsp.codelens.refresh,
                    --     })
                    -- end

                    if client.name == "clangd" then
                        require("plugins.lsp.keymaps").clangd(bufnr)
                    end
                end,
            })
        end,
    },
}
