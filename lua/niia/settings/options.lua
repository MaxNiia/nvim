-- Global
vim.g.have_nerd_font = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Options
vim.opt.ai = true
vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.autowriteall = true
vim.opt.backspace = "indent,eol,start"
vim.opt.belloff = "all"
vim.opt.cmdheight = 0
vim.opt.colorcolumn = "+1"
vim.opt.compatible = false
vim.opt.cul = true
vim.opt.culopt = "both"
-- vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldcolumn = "auto:1"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

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

vim.opt.hidden = true
vim.opt.smoothscroll = true
vim.opt.history = 1000
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.mousemodel = "extend"
vim.opt.number = vim.g.nu
vim.opt.rnu = vim.g.rnu
vim.opt.numberwidth = 2
vim.opt.pumblend = 0
vim.opt.ruler = true
vim.opt.scrolloff = 5
vim.opt.shiftwidth = 4
vim.opt.showtabline = 0
vim.opt.showcmd = true
vim.opt.showcmdloc = "statusline"
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 2
vim.opt.signcolumn = "yes:1"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.spelloptions = "camel"
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabpagemax = 50
vim.opt.tabstop = 8
vim.opt.termguicolors = true
vim.opt.textwidth = 80
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100
vim.opt.undofile = true
vim.opt.wildmenu = true
vim.opt.winblend = 0
vim.opt.diffopt = "filler,internal,closeoff,algorithm:histogram,context:5,linematch:60"

local icons = require("niia.utils.icons")
vim.opt.fillchars:append({
    diff = icons.misc.slash,
    foldopen = icons.fold.open,
    foldclose = icons.fold.closed,
    foldsep = icons.fold.separator,
    fold = " ",
    stl = '━',
    stlnc = '━',
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
]])

if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.o.shell = "powershell.exe"
end
