package.preload["nvim-web-devicons"] = function()
    require("mini.icons").mock_nvim_web_devicons()
    return package.loaded["nvim-web-devicons"]
end

local gen_loader = require("mini.snippets").gen_loader
local snippets = {
    gen_loader.from_file(vim.fn.stdpath("config") .. "/snippets/global.json"),
    gen_loader.from_lang(),
}

if vim.g.extra_snippets ~= nil then
    snippets = vim.tbl_deep_extend("force", snippets, vim.g.extra_snippets(gen_loader))
end

require("mini.snippets").setup({
    snippets = snippets,
})
MiniSnippets.start_lsp_server()

local make_stop = function()
    local au_opts = { pattern = "*:n", once = true }
    au_opts.callback = function()
        while MiniSnippets.session.get() do
            MiniSnippets.session.stop()
        end
    end
    vim.api.nvim_create_autocmd("ModeChanged", au_opts)
end

local opts = { pattern = "MiniSnippetsSessionStart", callback = make_stop }
vim.api.nvim_create_autocmd("User", opts)

require("mini.splitjoin").setup()
require("mini.visits").setup()
require("mini.icons").setup({
    file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
    },
    filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
    },
})
require("mini.extra").setup()

local gen_ai_spec = require("mini.extra").gen_ai_spec
local ai = require("mini.ai")
require("mini.ai").setup({
    custom_textobjects = {
        B = gen_ai_spec.buffer(),
        D = gen_ai_spec.diagnostic(),
        I = gen_ai_spec.indent(),
        L = gen_ai_spec.line(),
        N = gen_ai_spec.number(),
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
        o = ai.gen_spec.treesitter({
            a = { "@loop.outer", "@conditional.outer" },
            i = { "@loop.inner", "@conditional.inner" },
        }),
    },
    n_lines = 500,
})
require("mini.bracketed").setup({
    comment = {
        suffix = "z",
    },
})
require("mini.comment").setup({
    options = {
        custom_commentstring = nil,
        ignore_blank_line = true,
    },
})
require("mini.surround").setup({
    custom_surroundings = {
        ["("] = {
            input = { "%b()", "^.().*().$" },
            output = { left = "(", right = ")" },
        },
        ["["] = {
            input = { "%b[]", "^.().*().$" },
            output = { left = "[", right = "]" },
        },
        ["{"] = {
            input = { "%b{}", "^.().*().$" },
            output = { left = "{", right = "}" },
        },
        ["<"] = {
            input = { "%b<>", "^.().*().$" },
            output = { left = "<", right = ">" },
        },
    },
})

require("mini.jump").setup()
require("mini.jump2d").setup({
    mappings = { start_jumping = "<leader><space>" },
})
require("mini.cursorword").setup()
require("mini.align").setup()
require("mini.move").setup({
    mappings = {
        left = "<M-H>",
        right = "<M-L>",
        down = "<M-J>",
        up = "<M-K>",

        line_left = "<M-H>",
        line_right = "<M-L>",
        line_down = "<M-J>",
        line_up = "<M-K>",
    },
})
require("mini.operators").setup({
    replace = { prefix = "gR" },
})
require("mini.pairs").setup()

require("mini.sessions").setup({
    autoread = true,
    autowrite = true,
    directory = vim.fn.stdpath("data") .. "/sessions",
    file = "Session.vim",
})
vim.keymap.set("n", "<leader>ws", "<cmd>lua MiniSessions.write('Session.vim')<cr>", { desc = "Save session" })

-- Mini.visits keybinds
vim.keymap.set("n", "<leader>ma", function()
    MiniVisits.add_label()
end, { desc = "Add visit mark" })
vim.keymap.set("n", "<leader>md", function()
    MiniVisits.remove_label()
end, { desc = "Remove visit mark" })
vim.keymap.set("n", "<leader>ml", function()
    MiniVisits.select_label()
end, { desc = "List visit marks" })
vim.keymap.set("n", "<leader>mp", function()
    MiniVisits.select_path()
end, { desc = "List visit marks" })

local miniclue = require("mini.clue")
miniclue.setup({
    triggers = {
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },
        { mode = "i", keys = "<C-x>" },
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },
        { mode = "n", keys = "<C-w>" },
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
        { mode = "x", keys = "[" },
        { mode = "x", keys = "]" },
    },
    clues = {
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
        { mode = "n", keys = "<Leader>f", desc = "+find" },
        { mode = "n", keys = "<Leader>s", desc = "+search" },
        { mode = "n", keys = "<Leader>g", desc = "+git" },
        { mode = "n", keys = "<Leader>w", desc = "+sessions" },
        { mode = "n", keys = "<Leader>m", desc = "+marks/visits" },
        { mode = "n", keys = "<Leader>u", desc = "+toggles" },
        { mode = "n", keys = "<Leader>a", desc = "+parameter" },
        { mode = "n", keys = "gr", desc = "+lsp" },
        { mode = "x", keys = "gr", desc = "+lsp" },
    },
    window = {
        delay = 0,
    },
})

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
    highlighters = {
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})

local statusline = require("mini.statusline")

statusline.setup({
    content = {
        active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            local git = statusline.section_git({ trunc_width = 40 })
            local diagnostics = statusline.section_diagnostics({
                trunc_width = 75,
                signs = { ERROR = "", WARN = "", INFO = "", HINT = "" },
            })
            local lsp = statusline.section_lsp({ trunc_width = 75 })
            local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
            local location = statusline.section_location({ trunc_width = 75 })
            local search = statusline.section_searchcount({ trunc_width = 75 })
            local diff = statusline.section_diff({ trunc_width = 75 })

            return statusline.combine_groups({
                { hl = mode_hl, strings = { mode } },
                { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
                "%<", -- Separator
                "%=", -- Separator
                { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                { hl = mode_hl, strings = { search, location, "%S" } },
            })
        end,
        inactive = function()
            local filename = statusline.section_filename({ trunc_width = 140 })
            local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
            local diff = statusline.section_diff({ trunc_width = 75 })

            return statusline.combine_groups({
                "%<", -- Separator
                { hl = "MiniStatuslineFilename", strings = { filename } },
                "%=", -- Separator
                { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            })
        end,
    },
    use_icons = true,
})
