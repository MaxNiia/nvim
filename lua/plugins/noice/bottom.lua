return {
    presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = false,
        inc_rename = false,
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
