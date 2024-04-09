local my_doxygen = {
    { nil, "//! @file", { no_results = true, type = { "file" } } },
    { nil, "//! @brief $1", { no_results = true, type = { "func", "file", "class" } } },
    { nil, "", { no_results = true, type = { "file" } } },

    { "class_name", " //! @class %s", { type = { "class" } } },
    { "type", "//! @typedef %s", { type = { "type" } } },
    { nil, "//! @brief $1", { type = { "func", "class", "type" } } },
    { nil, "//!", { type = { "func", "class", "type" } } },
    { "tparam", "//! @tparam %s $1" },
    { "parameters", "//! @param %s $1" },
    { "return_statement", "//! @return $1" },
}

return {
    {
        "danymat/neogen",
        keys = {
            {
                "<leader>rd",
                function()
                    require("neogen").generate()
                end,
                mode = "n",
                desc = "Function annotation",
            },
            {
                "<leader>rc",
                function()
                    require("neogen").generate({ type = "class" })
                end,
                mode = "n",
                desc = "Class annotation",
            },
            {
                "<leader>rf",
                function()
                    require("neogen").generate({ type = "file" })
                end,
                mode = "n",
                desc = "File annotation",
            },
        },
        opts = {
            enabled = true,
            input_after_comment = true,
            snippet_engine = "luasnip",
            languages = {
                cpp = {
                    template = {
                        annotation_convention = "my_doxygen",
                        my_doxygen = my_doxygen,
                    },
                },
                c = {
                    template = {
                        annotation_convention = "my_doxygen",
                        my_doxygen = my_doxygen,
                    },
                },
            },
        },
    },
}
