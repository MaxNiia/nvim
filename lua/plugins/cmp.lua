return {
    {
        "tzachar/fuzzy.nvim",
        lazy = true,
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
    },
    {
        "hrsh7th/cmp-buffer",
        lazy = true,
        dependencies = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" },
    },
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        build = "make install_jsregexp",
        opts = {
            history = true,
            region_check_events = "InsertEnter",
            delete_check_events = "TextChanged,InsertLeave",
        },
        config = function(_, opts)
            if opts then
                require("luasnip").config.setup(opts)
            end
            vim.tbl_map(function(type)
                require("luasnip.loaders.from_" .. type).lazy_load()
            end, { "vscode", "snipmate", "lua" })
        end,
    },
    {
        "paopaol/cmp-doxygen",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "L3MON4D3/LuaSnip",
            "tzachar/fuzzy.nvim",
            "saadparwaiz1/cmp_luasnip",
            "paopaol/cmp-doxygen",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            "petertriho/cmp-git",
            "hrsh7th/cmp-cmdline",
        },
        opts = {
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            matching = {
                disallow_fuzzy_matching = true,
                disallow_fullfuzzy_matching = true,
                disallow_partial_fuzzy_matching = true,
                disallow_partial_matching = true,
                disallow_prefix_unmatching = false,
            },
            experimental = {
                ghost_text = true,
            },
            sources = {
                { name = "luasnip" },
            },
        },
        config = function(_, opts)
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
                    docuementation = cmp.config.window.bordered(),
                },
                sorting = {
                    comparators = {
                        cmp.config.compare.sort_text, -- this needs to be 1st
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.kind,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                formatting = {
                    format = function(entry, vim_item)
                        if vim.tbl_contains({ "path" }, entry.source.name) then
                            local icon, hl_group = require("nvim-web-devicons").get_icon(
                                entry:get_completion_item().label
                            )
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
                    ["<tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip" },
                    { name = "doxygen" },
                    { name = "fuzzy_buffer" },
                }, {

                    { name = "buffer" },
                }),
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                }, {
                    { name = "buffer" },
                }),
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "nvim_lsp_document_symbol" },
                }, {
                    { name = "buffer" },
                }),
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = { "Man", "!" },
                        },
                    },
                }),
            })

            require("cmp_git").setup()
        end,
    },
}
