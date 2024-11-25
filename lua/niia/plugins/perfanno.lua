return {
    {
        "t-troebst/perfanno.nvim",
        cmd = {
            "PerfLoadFlat",
            "PerfLoadCallGraph",
            "PerfLoadFlameGraph",
            "PerfPickEvent",
            "PerfAnnotate",
            "PerfAnnotateFunction",
            "PerfAnnotateSelection",
            "PerfToggleAnnotations",
            "PerfHottestLines",
            "PerfHottestSymbols",
            "PerfHottestCallersFunction",
            "PerfHottestCallersSelection",
        },
        keys = {
            { "<LEADER>hlf", ":PerfLoadFlat<CR>", desc = "Load flat data", mode = "n" },
            { "<LEADER>hlg", ":PerfLoadCallGraph<CR>", desc = "Load call graph", mode = "n" },
            { "<LEADER>hlo", ":PerfLoadFlameGraph<CR>", desc = "Load flame graph", mode = "n" },

            { "<LEADER>he", ":PerfPickEvent<CR>", desc = "Pick an event", mode = "n" },

            { "<LEADER>ha", ":PerfAnnotate<CR>", desc = "Annotes all open buffers", mode = "n" },
            { "<LEADER>hf", ":PerfAnnotateFunction<CR>", desc = "Annotates function", mode = "n" },
            { "<LEADER>ha", ":PerfAnnotateSelection<CR>", desc = "Annotates selected", mode = "n" },

            { "<LEADER>ht", ":PerfToggleAnnotations<CR>", desc = "Toggle annotation", mode = "n" },

            { "<LEADER>hh", ":PerfHottestLines<CR>", desc = "Find hottest line", mode = "n" },
            { "<LEADER>hs", ":PerfHottestSymbols<CR>", desc = "Find hottet symbol", mode = "n" },
            {
                "<LEADER>hc",
                ":PerfHottestCallersFunction<CR>",
                desc = "Find hottest caller function",
                mode = "n",
            },
            {
                "<LEADER>hc",
                ":PerfHottestCallersSelection<CR>",
                desc = "Find hottest caller selection",
                mode = "n",
            },
        },
        opts = {},
        config = function(_, opts)
            local perfanno = require("perfanno")
            local util = require("perfanno.util")

            vim.tbl_extend("force", opts, {
                line_highlights = util.make_bg_highlights(nil, "#CC3300", 10),
                vt_highlight = util.make_fg_highlight("#CC3300"),
            })
            perfanno.setup(opts)
        end,
    },
}
