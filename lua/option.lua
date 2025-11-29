-- Global variables
vim.g.have_nerd_font = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.autoformat = true
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Buffer local variables
vim.b.autoformat = true

-- Ensure autoformat is enabled for all buffers
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        if vim.b.autoformat == nil then
            vim.b.autoformat = true
        end
    end,
})

-- Options
vim.opt.ai = true
vim.opt.autocomplete = false -- Interferes with snacks.picker.
vim.opt.autoindent = true
vim.opt.wildignore:append({ ".DS_Store" })
vim.o.completeopt = "menuone,noselect,noinsert"
vim.o.pumheight = 15
vim.o.pumborder = "rounded"
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.opt.background = "dark"
local bg = (vim.env.NVIM_BACKGROUND or ""):lower()
if bg == "light" or bg == "dark" then
    vim.opt.background = bg
end
vim.opt.backspace = "indent,eol,start"
vim.opt.belloff = "all"
vim.opt.colorcolumn = "+1"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.diffopt =
    "inline:char,filler,internal,closeoff,algorithm:histogram,context:99,linematch:60,indent-heuristic"
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.foldcolumn = "auto:1"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = true
vim.opt.shiftwidth = 0
vim.opt.showbreak = ""
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.smoothscroll = true
vim.opt.softtabstop = 4
vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 8
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.title = true
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 10
vim.o.linebreak = true
vim.opt.undofile = true
vim.o.mousescroll = "ver:3,hor:0"
vim.o.winborder = "rounded"
vim.opt.wildmenu = true
vim.opt.winblend = 0
vim.opt.laststatus = 3
vim.opt.showcmdloc = "statusline"
vim.opt.cmdheight = 1
vim.opt.pumheight = 10
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.updatetime = 250
vim.o.showmode = false

require("vim._extui").enable({
    enable = true, -- Whether to enable or disable the UI.
})

local function fold_virt_text(result, s, lnum, coloff)
    if not coloff then
        coloff = 0
    end
    local text = ""
    local hl
    for i = 1, #s do
        local char = s:sub(i, i)
        local hls = vim.treesitter.get_captures_at_pos(0, lnum, coloff + i - 1)
        local _hl = hls[#hls]
        if _hl then
            local new_hl = "@" .. _hl.capture
            if new_hl ~= hl then
                table.insert(result, { text, hl })
                text = ""
                hl = nil
            end
            text = text .. char
            hl = new_hl
        else
            text = text .. char
        end
    end
    table.insert(result, { text, hl })
end

function _G.custom_foldtext()
    local start = vim.fn.getline(vim.v.foldstart):gsub("\t", string.rep(" ", vim.o.tabstop))
    local end_str = vim.fn.getline(vim.v.foldend)
    local end_ = vim.trim(end_str)
    local result = {}
    fold_virt_text(result, start, vim.v.foldstart - 1)
    table.insert(result, { " ... ", "Delimiter" })
    fold_virt_text(result, end_, vim.v.foldend - 1, #(end_str:match("^(%s+)") or ""))
    return result
end

vim.opt.foldtext = "v:lua.custom_foldtext()"

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client:supports_method("textDocument/foldingRange") then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
    end,
})

local icons = require("icons")
vim.opt.fillchars:append({
    diff = icons.misc.slash,
    foldopen = icons.fold.open,
    foldclose = icons.fold.closed,
    foldsep = icons.fold.separator,
    fold = " ",
    stl = " ",
    stlnc = " ",
})
vim.opt.listchars:append({
    tab = icons.chevron.right .. " ",
    trail = icons.misc.minus,
    extends = icons.chevron.right,
    precedes = icons.chevron.left,
    nbsp = icons.misc.plus,
})

-- Window
vim.wo.spell = true

vim.cmd([[
    set display+=truncate
    set formatoptions+=j
    setglobal tags-=./tags tags-=./tags; tags^=./tags;
    set complete-=i
    set nrformats-=octal
    set sessionoptions-=options
    set viewoptions-=options
    set clipboard+=unnamedplus
]])
