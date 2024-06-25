return {
    {
        "nvimtools/hydra.nvim",
        dependencies = {
            "jbyuki/venn.nvim",
        },
        event = "BufEnter",
        config = function(_, _)
            local hydra = require("hydra")

            hydra(require("plugins.hydra.venn"))
            hydra(require("plugins.hydra.options_changer")())
        end,
    },
}
