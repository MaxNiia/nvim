return {
    {
        "xzbdmw/clasp.nvim",
        opts = {
            ["{"] = "}",
            ['"'] = '"',
            ["'"] = "'",
            ["("] = ")",
            ["["] = "]",
            ["<"] = ">",
        },
        keys = {
            {
                "gh",
                function()
                    require("clasp").wrap("prev")
                end,

                mode = "n",
                desc = "Clasp previous",
            },
            {
                "gl",
                function()
                    require("clasp").wrap("next")
                end,

                mode = "n",
                desc = "Clasp next",
            },
            {
                "<c-h>",
                function()
                    require("clasp").wrap("prev")
                end,

                mode = "i",
                desc = "Clasp previous",
            },
            {
                "<c-l>",
                function()
                    require("clasp").wrap("next")
                end,

                mode = "i",
                desc = "Clasp previous",
            },
        },
    },
}
