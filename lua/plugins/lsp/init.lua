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
            {
                "<leader>d",
                function()
                    vim.lsp.buf.format({
                        async = true,
                    })
                end,
                desc = "Format",
            },
            {
                "<leader>a",
                vim.lsp.buf.code_action,
                desc = "Apply fix",
            },
            {
                "<leader>rn",
                vim.lsp.buf.rename,
                desc = "Rename",
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

            -- Keybinds
            local wk = require("which-key")
            local navic = require("nvim-navic")
            local on_attach = function(client, bufnr)
                if client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end

                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                if client.server_capabilities.inlayHintProvider then
                    wk.register({
                        t = {
                            function()
                                vim.lsp.buf.inlay_hint(bufnr, nil)
                            end,
                            "Toggle inlay hints",
                        },
                    }, { prefix = "<leader>w", buffer = bufnr })

                    vim.lsp.buf.inlay_hint(bufnr, true)
                end
                -- Mappings
                wk.register({
                    g = {
                        name = "Go to",
                        D = {
                            vim.lsp.buf.declaration,
                            "Go to declaration",
                        },
                        d = {
                            vim.lsp.buf.definition,
                            "Go to definition",
                        },
                        i = {
                            vim.lsp.buf.implementation,
                            "Go to implementation",
                        },
                        r = {
                            require("telescope.builtin").lsp_references,
                            "Go to references",
                        },
                    },
                    -- K = {
                    -- 	vim.lsp.buf.hover,
                    -- 	"Hover",
                    -- },
                    K = {
                        function()
                            local winid = require("ufo").peekFoldedLinesUnderCursor()
                            if not winid then
                                -- choose one of coc.nvim and nvim lsp
                                require("pretty_hover").hover()
                            end
                        end,
                        "Hover",
                    },
                    ["<c-q>"] = {
                        function()
                            require("pretty_hover").close()
                        end,
                        "Close Hover",
                    },
                    ["<C-k>"] = {
                        vim.lsp.buf.signature_help,
                        "Signature",
                    },
                    ["<leader>"] = {
                        w = {
                            name = "LSP",
                            a = {
                                vim.lsp.buf.add_workspace_folder,
                                "Add workspace folder",
                            },
                            r = {
                                vim.lsp.buf.remove_workspace_folder,
                                "Remove workspace folder",
                            },
                            l = {
                                function()
                                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                                end,
                                "List workspace folder",
                            },
                        },
                    },
                }, { buffer = bufnr })

                if client.name == "clangd" then
                    wk.register({
                        o = {
                            "<cmd>ClangdSwitchSourceHeader<CR>",
                            "Switch Header/Source",
                        },
                    }, {
                        prefix = "<leader>",
                        buffer = bufnr,
                    })
                end
                -- Normal Mode
            end

            local servers = opts.servers
            local capabilities = require("cmp_nvim_lsp").default_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            )

            -- Specify otherwise clangd seems to use utf-8
            capabilities.offsetEncoding = { "utf-16" }
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                    on_attach = on_attach,
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
        end,
    },
}
