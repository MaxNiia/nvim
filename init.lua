-- Before Lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.cmd([[
if has("nvim")
  let $GIT_EDITOR = 'nvim --cmd "let g:unception_block_while_host_edits=1"'
endif

autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
]])

OPTIONS = {
    mini_files = {
        value = true,
        key = "mf",
        description = "Enable mini.files",
        prompt = nil,
        callback = nil,
    },
    colorblind = {
        value = false,
        key = "cbe",
        description = "Enable colorblind mode",
        prompt = nil,
        callback = nil,
    },
    colorblind_protan = {
        value = 0.0,
        key = "cbp",
        description = "Colorblind protan severity",
        prompt = "Enter desired severity",
        callback = nil,
    },
    colorblind_deutan = {
        value = 0.0,
        key = "cbd",
        description = "Colorblind deutan severity",
        prompt = "Enter desired severity",
        callback = nil,
    },
    colorblind_tritan = {
        value = 0.0,
        key = "cbt",
        description = "Colorblind tritan severity",
        prompt = "Enter desired severity",
        callback = nil,
    },
    virtual_edit = {
        value = "none",
        key = "ve",
        description = "Virtual edit mode",
        prompt = {
            "block",
            "insert",
            "all",
            "onemore",
            "none",
        },
        callback = function()
            vim.o.virtualedit = OPTIONS.virtual_edit.value
        end,
    },
    invisible = {
        value = false,
        key = "ic",
        description = "Toggle invisible characters",
        prompt = nil,
        callback = function()
            vim.o.list = OPTIONS.invisible.value
        end,
    },
    word_wrap = {
        value = true,
        key = "ww",
        description = "Toggle word wrap",
        prompt = nil,
        callback = function()
            if OPTIONS.word_wrap.value == true then
                vim.o.wrap = true
                -- Dealing with word wrap:
                -- If cursor is inside very long line in the file than wraps
                -- around several rows on the screen, then 'j' key moves you to
                -- the next line in the file, but not to the next row on the
                -- screen under your previous position as in other editors. These
                -- bindings fixes this.
                vim.keymap.set("n", "k", function()
                    return vim.v.count > 0 and "k" or "gk"
                end, { expr = true, desc = "k or gk" })
                vim.keymap.set("n", "j", function()
                    return vim.v.count > 0 and "j" or "gj"
                end, { expr = true, desc = "j or gj" })
            else
                vim.o.wrap = false
                vim.keymap.del("n", "k")
                vim.keymap.del("n", "j")
            end
        end,
    },
    number = {
        value = true,
        key = "ln",
        description = "Toggle line numbers",
        prompt = nil,
        callback = function()
            vim.o.number = OPTIONS.number.value
        end,
    },
    relative_number = {
        value = true,
        key = "rn",
        description = "Toggle relative line numbers",
        prompt = nil,
        callback = function()
            vim.o.relativenumber = OPTIONS.relative_number.value
        end,
    },
    toggleterm = {
        value = false,
        key = "tt",
        description = "Enable toggleterm",
        prompt = nil,
        callback = nil,
    },
    oled = {
        value = false,
        key = "bb",
        description = "Black background",
        prompt = nil,
        callback = nil,
    },
    copilot = {
        value = false,
        key = "cc",
        description = "Enable copilot",
        prompt = nil,
        callback = nil,
    },
    popup = {
        value = true,
        key = "cp",
        description = "Enable command line popup",
        prompt = nil,
        callback = nil,
    },
    harpoon = {
        value = false,
        key = "h",
        description = "Enable Harpoon",
        prompt = nil,
        callback = nil,
    },
    buffer_mode = {
        value = false,
        key = "bm",
        description = "Normal mode in buffers",
        prompt = nil,
        callback = nil,
    },
    lsp_lines = {
        value = false,
        key = "ll",
        description = "Diagnostics on separate line",
        prompt = nil,
        callback = nil,
    },
    prompt_end = {
        value = "%$ ",
        key = "tp",
        description = "Terminal prompt",
        prompt = "Enter your terminal prompt",
        callback = nil,
    },
    git_signs = {
        value = false,
        key = "gs",
        description = "Toggle git signs",
        prompt = nil,
        callback = function()
            require("gitsigns").toggle_signs(OPTIONS.git_signs.value)
        end,
    },
    git_deleted = {
        value = false,
        key = "gd",
        description = "Toggle git deleted highlights",
        prompt = nil,
        callback = function()
            require("gitsigns").toggle_deleted(OPTIONS.git_deleted.value)
        end,
    },
    git_line_hl = {
        value = false,
        key = "gl",
        description = "Toggle git line highlights",
        prompt = nil,
        callback = function()
            require("gitsigns").toggle_linehl(OPTIONS.git_line_hl.value)
        end,
    },
    font_size = {
        value = 11.0,
        key = "fs",
        description = "Font size",
        prompt = "Enter desired font size",
        callback = function()
            vim.o.guifont = "FiraCode Nerd Font:h"
                .. tostring(OPTIONS.font_size.value > 0 and OPTIONS.font_size.value or 11)
        end,
    },
    spell = {
        value = true,
        key = "sc",
        description = "Toggle spell checker",
        prompt = nil,
        callback = function()
            vim.o.spell = OPTIONS.spell.value
        end,
    },
    scale_size = {
        value = 1.0,
        key = "ns",
        description = "Change neovide scale",
        prompt = "Neovide scale",
        callback = function()
            vim.g.neovide_scale_factor = OPTIONS.scale_size.value
        end,
    },
    wiki = {
        value = "~",
        key = "wp",
        description = "Wiki path",
        prompt = "Enter desired path to wiki files",
        callback = nil,
    },
    wikis = {
        value = {
            work = {
                key = "w",
            },
            personal = {
                key = "p",
            },
        },
        key = "wf",
        description = "Wiki folder",
        prompt = { add = { folder = { "key" } }, remove = "folder" },
        callback = nil,
    },
    early_retirement = {
        value = false,
        key = "er",
        description = "Enable auto closing unused buffers",
        prompt = nil,
        callback = nil,
    },
    fzf = {
        value = false,
        key = "fz",
        description = "Enable fzf",
        prompt = nil,
        callback = nil,
    },
    transparent = {
        value = false,
        key = "tr",
        description = "Enable transparent background",
        prompt = nil,
        callback = nil,
    },
    bold = {
        value = true,
        key = "tb",
        description = "Enable bold text",
        prompt = nil,
        callback = nil,
    },
    italic = {
        value = true,
        key = "ti",
        description = "Enable italic text",
        prompt = nil,
        callback = nil,
    },
    underline = {
        value = true,
        key = "tu",
        description = "Enable underline text",
        prompt = nil,
        callback = nil,
    },
    dim_inactive = {
        value = false,
        key = "di",
        description = "Dim inactive windows",
        prompt = nil,
        callback = nil,
    },
}

require("utils.config").load_config()

local uname = vim.uv.os_uname()

_G.OS = uname.sysname
_G.IS_MAC = OS == "Darwin"
_G.IS_LINUX = OS == "Linux"
_G.IS_WINDOWS = OS:find("Windows") and true or false
_G.IS_WSL = IS_LINUX and uname.release:find("Microsoft") and true or false

if vim.g.neovide then
    require("configs.neovide")
elseif vim.g.vscode then
    require("configs.vscode")
end

require("configs.options")
require("configs.autocmd")
require("configs.commands")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {})

-- Load current theme, decided by <leader>fc.
require("current-theme")
