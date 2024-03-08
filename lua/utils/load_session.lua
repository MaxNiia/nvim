return function()
    require("persistence").start()
    require("persistence").load()
end
