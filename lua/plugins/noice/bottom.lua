return {
    presets = {
        bottom_search = true,
    },
    cmdline = {
        view = "cmdline",
    },
    routes = {
        {
            filter = {
                event = "msg_show",
                kind = "",
                find = "written",
            },
            opts = { skip = true },
        },
    },
}
