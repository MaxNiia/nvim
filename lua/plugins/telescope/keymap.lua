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
        "<leader>fc",
        "<cmd>Telescope colorscheme<cr>",
        desc = "Colorscheme",
    },
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
    { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume", mode = { "v", "n" } },
    {
        "<leader>ft",
        "<cmd>Telescope<cr>",
        desc = "Telescope",
        mode = { "v", "n" },
    },
    {
        "<leader>ff",
        call_telescope("files"),
        desc = "Files (root)",
        mode = { "v", "n" },
    },
    {
        "<leader>fG",
        call_telescope("git_files"),
        desc = "Files (git)",
        mode = { "v", "n" },
    },
    {
        "<leader>fF",
        call_telescope("files", { cwd = false }),
        desc = "Files (cwd)",
        mode = { "v", "n" },
    },
    {
        "<leader>fs",
        function()
            require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Search (root dir)",
        mode = { "v", "n" },
    },
    {
        "<leader>fS",
        function()
            require("telescope").extensions.live_grep_args.live_grep_args({ cwd = false })
        end,
        desc = "Search (cwd)",
        mode = { "v", "n" },
    },
    {
        "<leader>fb",
        function()
            require("telescope.builtin").buffers({ sort_mru = true })
        end,
        desc = "Buffers",
        mode = { "v", "n" },
    },
    {
        "<leader>fo",
        "<cmd>Telescope oldfiles<CR>",
        desc = "Old files (root)",
        mode = { "v", "n" },
    },
    {
        "<leader>fO",
        call_telescope("oldfiles", { cwd = vim.loop.cwd() }),
        desc = "Old files (cwd)",
        mode = { "v", "n" },
    },
    {
        "<leader>fq",
        "<cmd>Telescope spell_suggest<CR>",
        desc = "Dictionary",
        mode = { "v", "n" },
    },
    {
        "<leader>fp",
        "<cmd>Telescope projects<CR>",
        desc = "Project",
        mode = { "v", "n" },
    },
    {
        "<leader>fm1",
        call_telescope("man_pages", {
            sections = { "1" },
        }),
        desc = "Executables/Shell Commands",
        mode = { "v", "n" },
    },
    {
        "<leader>fm2",
        call_telescope("man_pages", {
            sections = { "2" },
        }),
        desc = "System calls",
        mode = { "v", "n" },
    },
    {
        "<leader>fm3",
        call_telescope("man_pages", {
            sections = { "3" },
        }),
        desc = "Library calls",
        mode = { "v", "n" },
    },
    {
        "<leader>fm4",
        call_telescope("man_pages", {
            sections = { "4" },
        }),
        desc = "Special files",
        mode = { "v", "n" },
    },
    {
        "<leader>fm5",
        call_telescope("man_pages", {
            sections = { "5" },
        }),
        desc = "File formats and conventions",
        mode = { "v", "n" },
    },
    {
        "<leader>fm6",
        call_telescope("man_pages", {
            sections = { "6" },
        }),
        desc = "Games",
        mode = { "v", "n" },
    },
    {
        "<leader>fm7",
        call_telescope("man_pages", {
            sections = { "7" },
        }),
        desc = "Misc",
        mode = { "v", "n" },
    },
    {
        "<leader>fm8",
        call_telescope("man_pages", {
            sections = { "8" },
        }),
        desc = "System admin",
        mode = { "v", "n" },
    },
    {
        "<leader>fm9",
        call_telescope("man_pages", {
            sections = { "9" },
        }),
        desc = "Kernel routines (non standard)",
        mode = { "v", "n" },
    },
    {
        "<leader>fk",
        "<cmd>Telescope keymaps<cr>",
        desc = "Key Maps",
        mode = { "v", "n" },
    },

    -- GIT
    {
        "<leader>fgs",
        "<cmd>Telescope git_status<CR>",
        desc = "Status",
        mode = { "v", "n" },
    },
    {
        "<leader>fgb",
        "<cmd>Telescope git_branches<CR>",
        desc = "Branches",
        mode = { "v", "n" },
    },
    {
        "<leader>fgc",
        "<cmd>Telescope git_commits<CR>",
        desc = "Commits",
        mode = { "v", "n" },
    },

    -- DAP
    {
        "<leader>fdc",
        "<cmd>Telescope dap commands<CR>",
        desc = "Commands",
        mode = { "v", "n" },
    },
    {
        "<leader>fdb",
        "<cmd>Telescope dap list_breakpoints<CR>",
        desc = "Breakpoints",
        mode = { "v", "n" },
    },
    {
        "<leader>fdv",
        "<cmd>Telescope dap variables<CR>",
        desc = "Variables",
        mode = { "v", "n" },
    },
    {
        "<leader>fdx",
        "<cmd>Telescope dap configurations<CR>",
        desc = "Configurations",
        mode = { "v", "n" },
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
        mode = { "v", "n" },
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
        mode = { "v", "n" },
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
        mode = { "v", "n" },
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
        mode = { "v", "n" },
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
        mode = { "v", "n" },
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
        mode = { "v", "n" },
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
        mode = { "v", "n" },
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
        mode = { "v", "n" },
    },

    -- Harpoon
    {
        "<leader>fh",
        "<cmd>Telescope harpoon marks<CR>",
        desc = "Harpoon",
        mode = { "v", "n" },
    },

    -- File Browser
    {
        "<leader>fe",
        "<cmd>Telescope file_browser<CR>",
        desc = "Browser (root)",
        mode = { "v", "n" },
    },
    {
        "<leader>fE",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
        desc = "Browser (cwd)",
        mode = { "v", "n" },
    },
    -- LEADER
    {
        "<leader>fM",
        function()
            require("telescope").extensions.monorepo.monorepo()
        end,
        desc = "Monorepo",
        mode = { "v", "n" },
    },
    {
        "<leader>,",
        "<cmd>Telescope buffers show_all_buffers=true<cr>",
        desc = "Switch buffers",
        mode = { "v", "n" },
    },
    {
        "<leader>/",
        function()
            require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        call_telescope("live_grep"),
        desc = "Search (root dir)",
        mode = { "v", "n" },
    },
    {
        "<leader>?",
        function()
            require("telescope").extensions.live_grep_args.live_grep_args({ cwd = false })
        end,
        desc = "Search (cwd)",
        mode = { "v", "n" },
    },
    {
        "<leader>:",
        "<cmd>Telescope command_history<cr>",
        desc = "Command History",
        mode = { "v", "n" },
    },
}
