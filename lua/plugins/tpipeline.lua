return {{
    "vimpostor/vim-tpipeline",
    config = function()
        vim.g.tpipeline_split = 1
        vim.g.tpipeline_clearstl = 1
-- yes
-- let g:tpipeline_split = 0
-- let g:tpipeline_clearstl = 1

--maybe
        vim.cmd([[
            set fcs=stlnc:-
            set fcs+=stl:-
        ]])
    end,
},}
