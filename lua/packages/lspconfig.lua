-- Mappings.
local wk = require("which-key")
wk.register({
    j = {
        vim.diagnostic.open_float,
        "Open float",
    },
    q = {
        vim.diagnostic.setloclist,
        "Set loc list",
    },
}, {
    prefix = "<leader>",
})

wk.register({
    k = {
        vim.diagnostic.goto_prev,
        "Previous diagnostic",
    },
    j = {
        vim.diagnostic.goto_next,
        "Next diagnostic",
    },
}, {
    prefix = "<C>",
})

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

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
                {},
                "Go to references",
            },
        },
        K = {
            vim.lsp.buf.hover,
            "Hover",
        },
        ["<C-k>"] = {
            vim.lsp.buf.signature_help,
            "Signature",
        },
        ["<leader>"] = {
            w = {
                name = "Workspace",
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
            rn = {
                vim.lsp.buf.rename,
                "Rename",
            },
            d = {
                function()
                    vim.lsp.buf.format({
                        async = true,
                    })
                end,
                "Format",
            },
            a = {
                vim.lsp.buf.code_action,
                "Apply fix",
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

local lsp_flags = {
    debounce_text_change = 150,
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.offsetEncoding = "utf-8"

require("lspconfig")["pylsp"].setup({
    settings = {
        pylsp = {
            plugins = {
            }
        }
    }
})

require("lspconfig")["clangd"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    cmd = {
        "clangd",
        "--background-index=true",
        "--clang-tidy=true",
        "--completion-style=detailed",
        "--all-scopes-completion=true",
        "--query-driver='/usr/bin/clang, /usr/bin/clang++'", -- gcc
    },
})

require("lspconfig")["cmake"].setup({
    capabilities = capabilities,
    buildDirectory = "build/rcsos-2.4.0_x86_4.4.50_rt63/Debug",
})

require("lspconfig")["jsonnet_ls"].setup({
    capabilities = capabilities,
})

require("lspconfig")["yamlls"].setup({
    capabilities = capabilities,
})

require("lspconfig")["marksman"].setup({
    capabilities = capabilities,
})

require("lspconfig")["sumneko_lua"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = {
                    "vim",
                },
            },
            workspace = {
                libray = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
    single_file_support = true,
})

require("lspconfig")["rust_analyzer"].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            proMacro = {
                enable = true,
            },
        },
    },
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- luasnip setup
local luasnip = require("luasnip")

-- Lspkind
local lspkind = require("lspkind")

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
    },
    formatting = {
        format = function(entry, vim_item)
            if vim.tbl_contains({ "path" }, entry.source.name) then
                local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
                if icon then
                    vim_item.kind = icon
                    vim_item.kind_hl_group = hl_group
                    return vim_item
                end
            end
            return lspkind.cmp_format({ with_text = false })(entry, vim_item)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
})
