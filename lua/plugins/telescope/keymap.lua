local utils = require("plugins.telescope.utils")
local call_telescope = utils.call_telescope

local keymaps = {
    {
        "<leader>fp",
        ":lua require'telescope'.extensions.project.project{display_type = 'full'}<cr>",
        desc = "Project",
        mode = { "v", "n" },
    },
    {
        "<leader>fm",
        function()
            require("telescope").extensions.monorepo.monorepo()
        end,
        desc = "Monorepo",
        mode = { "v", "n" },
    },
    {
        "<leader>fM1",
        call_telescope("man_pages", {
            sections = { "1" },
        }),
        desc = "Executables/Shell Commands",
        mode = { "v", "n" },
    },
    {
        "<leader>fM2",
        call_telescope("man_pages", {
            sections = { "2" },
        }),
        desc = "System calls",
        mode = { "v", "n" },
    },
    {
        "<leader>fM3",
        call_telescope("man_pages", {
            sections = { "3" },
        }),
        desc = "Library calls",
        mode = { "v", "n" },
    },
    {
        "<leader>fM4",
        call_telescope("man_pages", {
            sections = { "4" },
        }),
        desc = "Special files",
        mode = { "v", "n" },
    },
    {
        "<leader>fM5",
        call_telescope("man_pages", {
            sections = { "5" },
        }),
        desc = "File formats and conventions",
        mode = { "v", "n" },
    },
    {
        "<leader>fM6",
        call_telescope("man_pages", {
            sections = { "6" },
        }),
        desc = "Games",
        mode = { "v", "n" },
    },
    {
        "<leader>fM7",
        call_telescope("man_pages", {
            sections = { "7" },
        }),
        desc = "Misc",
        mode = { "v", "n" },
    },
    {
        "<leader>fM8",
        call_telescope("man_pages", {
            sections = { "8" },
        }),
        desc = "System admin",
        mode = { "v", "n" },
    },
    {
        "<leader>fM9",
        call_telescope("man_pages", {
            sections = { "9" },
        }),
        desc = "Kernel routines (non standard)",
        mode = { "v", "n" },
    },
    { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo history", mode = { "v", "n" } },
    { "<leader>fN", "<cmd>Telescope noice<cr>", desc = "Noice", mode = { "v", "n" } },
    { "<leader>fn", "<cmd>Telescope notify<cr>", desc = "Noice", mode = { "v", "n" } },
}

local optional_keymaps = {
    -- LEADER s
    {
        "<leader>s",

        function()
            local lga = require("telescope-live-grep-args.shortcuts")
            lga.grep_visual_selection()
        end,
        desc = "Grep string (root)",
        mode = { "v" },
    },
    {
        "<leader>S",
        function()
            local lga = require("telescope-live-grep-args.shortcuts")
            lga.grep_visual_selection({ cwd = false })
        end,
        desc = "Grep string (cwd)",
        mode = { "v" },
    },
    {
        "<leader>s",

        function()
            local lga = require("telescope-live-grep-args.shortcuts")
            lga.grep_word_under_cursor()
        end,
        desc = "Grep string (root)",
        mode = { "n" },
    },
    {
        "<leader>S",
        function()
            local lga = require("telescope-live-grep-args.shortcuts")
            lga.grep_word_under_cursor({ cwd = false })
        end,
        desc = "Grep string (cwd)",
        mode = { "n" },
    },
    -- LEADER f
    {
        "<leader>fc",
        "<cmd>Telescope colorscheme<cr>",
        desc = "Colorscheme",
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
        "<leader>fgf",
        call_telescope("git_files"),
        desc = "Files (git, root)",
        mode = { "v", "n" },
    },
    {
        "<leader>fgF",
        call_telescope("git_files", { cwd = false }),
        desc = "Files (git, cwd)",
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
        desc = "Tab buffers",
        mode = { "v", "n" },
    },
    {
        "<leader>fB",
        function()
            require("telescope.builtin").live_grep({ grep_open_files = true })
        end,
        desc = "Grep in buffers",
        mode = { "v", "n" },
    },
    {
        "<leader>fo",
        "<cmd>Telescope oldfiles<cr>",
        desc = "Old files (root)",
        mode = { "v", "n" },
    },
    {
        "<leader>fO",
        call_telescope("oldfiles", { cwd = vim.uv.cwd() }),
        desc = "Old files (cwd)",
        mode = { "v", "n" },
    },
    {
        "<leader>fq",
        "<cmd>Telescope spell_suggest<cr>",
        desc = "Dictionary",
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
        "<cmd>Telescope git_status<cr>",
        desc = "Status",
        mode = { "v", "n" },
    },
    {
        "<leader>fgb",
        "<cmd>Telescope git_branches<cr>",
        desc = "Branches",
        mode = { "v", "n" },
    },
    {
        "<leader>fgc",
        "<cmd>Telescope git_bcommits<cr>",
        desc = "File Commits",
        mode = { "v", "n" },
    },
    {
        "<leader>fgC",
        "<cmd>Telescope git_commits<cr>",
        desc = "Commits",
        mode = { "v", "n" },
    },

    -- DAP
    {
        "<leader>fdc",
        "<cmd>Telescope dap commands<cr>",
        desc = "Commands",
        mode = { "v", "n" },
    },
    {
        "<leader>fdb",
        "<cmd>Telescope dap list_breakpoints<cr>",
        desc = "Breakpoints",
        mode = { "v", "n" },
    },
    {
        "<leader>fdv",
        "<cmd>Telescope dap variables<cr>",
        desc = "Variables",
        mode = { "v", "n" },
    },
    {
        "<leader>fdx",
        "<cmd>Telescope dap configurations<cr>",
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

    -- Marks
    {
        "<leader>fh",
        function()
            if OPTIONS.harpoon.value then
                require("telescope").extensions.harpoon()
            else
                require("telescope.builtin").marks()
            end
        end,
        desc = OPTIONS.harpoon.value and "Harpoon" or "Marks",
        mode = { "v", "n" },
    },
    -- LEADER
    {
        "<leader>:",
        "<cmd>Telescope command_history<cr>",
        desc = "Command History",
        mode = { "v", "n" },
    },
}

if not OPTIONS.fzf.value then
    keymaps = vim.tbl_extend("force", keymaps, optional_keymaps)
end

return keymaps
