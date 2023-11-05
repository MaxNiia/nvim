local utils = require("plugins.telescope.utils")
local call_telescope = utils.call_telescope

return {
    -- LEADER r
    {
        "<leader>rr",
        "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
        desc = "Refactor Telescope",
        mode = "v",
    },
    -- LEADER f
    {
        "<leader>fj",
        "<cmd>Telescope grep_string<cr>",
        desc = "Grep string (root)",
        mode = {
            "v",
            "n",
        },
    },
    {
        "<leader>fJ",
        call_telescope("grep_string"),
        desc = "Grep string (cwd)",
        mode = {
            "v",
            "n",
        },
    },
    { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume" },
    {
        "<leader>ft",
        "<cmd>Telescope<cr>",
        desc = "Telescope",
    },
    {
        "<leader>ff",
        call_telescope("files"),
        desc = "Files (root)",
    },
    {
        "<leader>fG",
        call_telescope("git_files"),
        desc = "Files (git)",
    },
    {
        "<leader>fF",
        call_telescope("files", { cwd = false }),
        desc = "Files (cwd)",
    },
    {
        "<leader>fs",
        function()
            require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        call_telescope("live_grep"),
        desc = "Search (root dir)",
    },
    {
        "<leader>fS",
        function()
            require("telescope").extensions.live_grep_args.live_grep_args({ cwd = false })
        end,
        desc = "Search (cwd)",
    },
    {
        "<leader>fb",
        function()
            require("telescope").builtin.buffers({ sort_mru = true })
        end,
        desc = "Buffers",
    },
    {
        "<leader>fo",
        "<cmd>Telescope oldfiles<CR>",
        desc = "Old files (root)",
    },
    {
        "<leader>fO",
        call_telescope("oldfiles", { cwd = vim.loop.cwd() }),
        desc = "Old files (cwd)",
    },
    {
        "<leader>fq",
        "<cmd>Telescope spell_suggest<CR>",
        desc = "Dictionary",
    },
    {
        "<leader>fp",
        "<cmd>Telescope projects<CR>",
        desc = "Project",
    },
    { "<leader>fn", "<cmd>Telescope noice<CR>", desc = "Noice" },
    { "<leader>fN", "<cmd>Telescope notify<CR>", desc = "Notify" },
    {
        "<leader>fm1",
        call_telescope("man_pages", {
            sections = { "1" },
        }),
        desc = "Executables/Shell Commands",
    },
    {
        "<leader>fm2",
        call_telescope("man_pages", {
            sections = { "2" },
        }),
        desc = "System calls",
    },
    {
        "<leader>fm3",
        call_telescope("man_pages", {
            sections = { "3" },
        }),
        desc = "Library calls",
    },
    {
        "<leader>fm4",
        call_telescope("man_pages", {
            sections = { "4" },
        }),
        desc = "Special files",
    },
    {
        "<leader>fm5",
        call_telescope("man_pages", {
            sections = { "5" },
        }),
        desc = "File formats and conventions",
    },
    {
        "<leader>fm6",
        call_telescope("man_pages", {
            sections = { "6" },
        }),
        desc = "Games",
    },
    {
        "<leader>fm7",
        call_telescope("man_pages", {
            sections = { "7" },
        }),
        desc = "Misc",
    },
    {
        "<leader>fm8",
        call_telescope("man_pages", {
            sections = { "8" },
        }),
        desc = "System admin",
    },
    {
        "<leader>fm9",
        call_telescope("man_pages", {
            sections = { "9" },
        }),
        desc = "Kernel routines (non standard)",
    },
    {
        "<leader>fk",
        "<cmd>Telescope keymaps<cr>",
        desc = "Key Maps",
    },

    -- GIT
    { "<leader>fgs", "<cmd>Telescope git_status<CR>", desc = "Status" },
    {
        "<leader>fgb",
        "<cmd>Telescope git_branches<CR>",
        desc = "Branches",
    },
    {
        "<leader>fgc",
        "<cmd>Telescope git_commits<CR>",
        desc = "Commits",
    },

    -- DAP
    {
        "<leader>fdc",
        "<cmd>Telescope dap commands<CR>",
        desc = "Commands",
    },
    {
        "<leader>fdb",
        "<cmd>Telescope dap list_breakpoints<CR>",
        desc = "Breakpoints",
    },
    {
        "<leader>fdv",
        "<cmd>Telescope dap variables<CR>",
        desc = "Variables",
    },
    {
        "<leader>fdx",
        "<cmd>Telescope dap configurations<CR>",
        desc = "Configurations",
    },

    -- LSP
    {
        "<leader>flr",
        function()
            require("telescope.builtin").lsp_references({
                fname_width = require("utils.sizes").fname_width,
                include_declaration = true,
                include_current_line = true,
                jump_type = "never",
                show_line = false,
            })
        end,
        desc = "References",
    },
    {
        "<leader>fli",
        function()
            require("telescope.builtin").lsp_incoming_calls({
                fname_width = require("utils.sizes").fname_width,
                show_line = false,
            })
        end,
        desc = "Incoming",
    },
    {
        "<leader>flo",
        function()
            require("telescope.builtin").lsp_outgoing_calls({
                fname_width = require("utils.sizes").fname_width,
                show_line = false,
            })
        end,
        desc = "Outgoing",
    },
    {
        "<leader>fld",
        function()
            require("telescope.builtin").lsp_definitions({
                fname_width = require("utils.sizes").fname_width,
                show_line = false,
            })
        end,
        desc = "Definitions",
    },
    {
        "<leader>flt",
        function()
            require("telescope.builtin").lsp_type_definitions({
                fname_width = require("utils.sizes").fname_width,
                show_line = false,
            })
        end,
        desc = "Type Definitions",
    },
    {
        "<leader>flj",
        function()
            require("telescope.builtin").lsp_implementations({
                fname_width = require("utils.sizes").fname_width,
                show_line = false,
            })
        end,
        desc = "Implementations",
    },
    {
        "<leader>fls",
        call_telescope("lsp_document_symbols", {
            fname_width = 40,
            symbol_width = 30,
            symbol_type_width = 10,
            symbols = {
                "Class",
                "Function",
                "Method",
                "Constructor",
                "Interface",
                "Module",
                "Struct",
                "Trait",
                "Field",
                "Property",
            },
        }),
        desc = "Goto Symbol",
    },
    {
        "<leader>flS",
        call_telescope("lsp_dynamic_workspace_symbols", {
            fname_width = 40,
            show_line = false,
            symbol_width = 40,
            symbols = {
                "Class",
                "Function",
                "Method",
                "Constructor",
                "Interface",
                "Module",
                "Struct",
                "Trait",
                "Field",
                "Property",
            },
        }),
        desc = "Goto Workspace Symbol",
    },

    -- Harpoon
    {
        "<leader>fh",
        "<cmd>Telescope harpoon marks<CR>",
        desc = "Harpoon",
    },

    -- File Browser
    {
        "<leader>fe",
        "<cmd>Telescope file_browser<CR>",
        desc = "Browser (root)",
    },
    {
        "<leader>fE",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
        desc = "Browser (cwd)",
    },
    -- LEADER
    {
        "<leader>fM",
        function()
            require("telescope").extensions.monorepo.monorepo()
        end,
        mode = "n",
        desc = "Monorepo",
    },
    {
        "<leader>,",
        "<cmd>Telescope buffers show_all_buffers=true<cr>",
        desc = "Switch buffers",
    },
    {
        "<leader>/",
        function()
            require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        call_telescope("live_grep"),
        desc = "Search (root dir)",
    },
    {
        "<leader>?",
        function()
            require("telescope").extensions.live_grep_args.live_grep_args({ cwd = false })
        end,
        desc = "Search (cwd)",
    },
    {
        "<leader>:",
        "<cmd>Telescope command_history<cr>",
        desc = "Command History",
    },
}
