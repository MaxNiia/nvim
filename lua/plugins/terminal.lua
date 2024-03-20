local prompt_end = function()
    if OPTIONS.prompt_end.value ~= "" then
        return OPTIONS.prompt_end.value
    elseif _G.IS_LINUX or _G.IS_WSL or _G.IS_MAC then
        return "%$ "
    elseif _G.IS_WINDOWS and not _G.IS_WSL then
        return "> "
    end
end

return {
    {
        "chomosuke/term-edit.nvim",
        lazy = OPTIONS.toggleterm.value,
        ft = OPTIONS.toggleterm.value and "toggleterm" or "",
        version = "1.*",
        opts = {
            prompt_end = prompt_end(),
        },
    },
}
