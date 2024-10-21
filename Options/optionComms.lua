OptionComms = Option:extend()

function OptionComms:new()
    local name = "Comms"
    local icon = love.graphics.newImage("Icons/Comms.png")
    local index = 4
    OptionComms.super.new(self, name, icon, index)
end

function OptionComms:goToScene()
    Terminal:hideAll()
    -- Terminal:getHidables()["SceneComms1"]:show()
end