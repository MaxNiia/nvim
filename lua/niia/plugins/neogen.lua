local i = {
    Tparam = "tparam",
    Parameter = "parameters",
    Return = "return_statement",
    ReturnTypeHint = "return_type_hint",
    ReturnAnonym = "return_anonym",
    ClassName = "class_name",
    Throw = "throw_statement",
    Yield = "expression_statement",
    Vararg = "varargs",
    Type = "type",
    ClassAttribute = "attributes",
    HasParameter = "has_parameters",
    HasReturn = "has_return",
    HasThrow = "has_throw",
    HasYield = "has_yield",
    ArbitraryArgs = "arbitrary_args",
    Kwargs = "kwargs",
}

local start = "/**"
local middle = " * "
local stop = " */"
local my_doxygen = {
    { nil, start, { no_results = true, type = { "func", "file", "class" } } },
    { nil, middle .. "@file", { no_results = true, type = { "file" } } },
    { nil, middle .. "@brief $1", { no_results = true, type = { "func", "file", "class" } } },
    { nil, stop, { no_results = true, type = { "func", "file", "class" } } },
    { nil, "", { no_results = true, type = { "file" } } },

    { nil, start, { type = { "func", "class", "type" } } },
    { i.ClassName, middle .. "@class %s", { type = { "class" } } },
    { i.Type, middle .. "@typedef %s", { type = { "type" } } },
    { nil, middle .. "@brief $1", { type = { "func", "class", "type" } } },
    { nil, middle, { type = { "func", "class", "type" } } },
    { i.Tparam, middle .. "@tparam %s $1" },
    { i.Parameter, middle .. "@param %s $1" },
    { i.Return, middle .. "@return $1" },
    { nil, stop, { type = { "func", "class", "type" } } },
}

return {
    {
        "danymat/neogen",
        keys = {
            {
                "<leader>rdf",
                function()
                    require("neogen").generate({})
                end,
                mode = "n",
                desc = "Function annotation",
            },
            {
                "<leader>rdc",
                function()
                    require("neogen").generate({ type = "class" })
                end,
                mode = "n",
                desc = "Class annotation",
            },
            {
                "<leader>rdF",
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
            snippet_engine = "nvim",
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
