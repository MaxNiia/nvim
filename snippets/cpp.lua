return {
    copyright = {
        prefix = "copyright",
        body = vim.g.copyright_func("//"),
        desc = "Insert a copyright header",
    },
    lambda = {
        prefix = "lambda",
        body = "[${1:captures}](${2:params}){${0:body}}",
        desc = "Lambda",
    },
}
