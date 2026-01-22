package.preload["nvim-web-devicons"] = function()
    require("mini.icons").mock_nvim_web_devicons()
    return package.loaded["nvim-web-devicons"]
end

local gen_loader = require("mini.snippets").gen_loader
local snippets = {
    gen_loader.from_file(vim.fn.stdpath("config") .. "snippets/global.json"),
    gen_loader.from_lang(),
}

if vim.g.extra_snippets ~= nil then
    snippets = vim.tbl_deep_extend("force", snippets, vim.g.extra_snippets(gen_loader))
end

require("mini.snippets").setup({
    snippets = snippets,
    mappings = {
        expand = "",
        jump_next = "",
        jump_prev = "",
        stop = "",
    },
})

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
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
    },
    filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
    },
})
require("mini.extra").setup()
local gen_ai_spec = require("mini.extra").gen_ai_spec
require("mini.ai").setup({
    custom_textobjects = {
        B = gen_ai_spec.buffer(),
        D = gen_ai_spec.diagnostic(),
        I = gen_ai_spec.indent(),
        L = gen_ai_spec.line(),
        N = gen_ai_spec.number(),
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
require("mini.pairs").setup()
require("mini.sessions").setup({
    autoread = true,
    autowrite = true,
    directory = vim.fn.stdpath("data") .. "/sessions",
    file = "Session.vim",
})
vim.keymap.set(
    "n",
    "<leader>ws",
    "<cmd>lua MiniSessions.write('Session.vim')<cr>",
    { desc = "Save session" }
)

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

local statusline = require("mini.statusline")

local function get_jira_issue()
    local issue = vim.g.Jira_current_issue
    if issue then
        return "🔑 " .. issue
    end
    return ""
end

statusline.setup({
    content = {
        active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            local git = statusline.section_git({ trunc_width = 40 })
            local diagnostics = statusline.section_diagnostics({
                trunc_width = 75,
                signs = { ERROR = "", WARN = "", INFO = "", HINT = "" },
            })
            local lsp = statusline.section_lsp({ trunc_width = 75 })
            local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
            local location = statusline.section_location({ trunc_width = 75 })
            local search = statusline.section_searchcount({ trunc_width = 75 })
            local diff = statusline.section_diff({ trunc_width = 75 })

            local jira = get_jira_issue()
            if statusline.is_truncated(100) then
                jira = ""
            end

            return statusline.combine_groups({
                { hl = mode_hl, strings = { mode } },
                { hl = "MiniStatuslineDevinfo", strings = { diff, diagnostics, lsp } },
                "%<", -- Separator
                { hl = "MiniStatuslineFilename", strings = { git, jira } },
                "%=", -- Separator
                { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                { hl = mode_hl, strings = { search, location } },
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
