return {
    guard = {
        prefix = "guard",
        body = table.concat({
            "#ifndef ${1:MY_HEADER_H}",
            "#define ${1:MY_HEADER_H}",
            "",
            "$0",
            "",
            "#endif /* ${1:MY_HEADER_H} */",
        }, "\n"),
        desc = "Include guard",
    },
}
