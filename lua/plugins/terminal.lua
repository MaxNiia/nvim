local prompt_end = function()
    if _G.prompt_end ~= "" then
        return _G.prompt_end
    elseif _G.IS_LINUX or _G.IS_WSL or _G.IS_MAC then
        return "%$ "
    elseif _G.IS_WINDOWS and not _G.IS_WSL then
        return "> "
    end
end

return {
    {
        "chomosuke/term-edit.nvim",
        lazy = _G.toggleterm,
        ft = _G.toggleterm and "toggleterm" or "",
        version = "1.*",
        opts = {
            prompt_end = prompt_end(),
        },
    },
}
