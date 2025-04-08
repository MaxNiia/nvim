return {
    lambda = {
        prefix = "lambda",
        body = "[${1:captures}](${2:params}){${0:body}}",
        desc = "Lambda",
    },
}
