for name, _ in pairs(OPTIONS.external.value) do
    require("external." .. name)
end
