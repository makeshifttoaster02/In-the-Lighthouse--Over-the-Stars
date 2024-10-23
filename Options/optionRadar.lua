OptionRadar = Option:extend()

function OptionRadar:new()
    local name = "Radar"
    local icon = love.graphics.newImage("Icons/Radar.png")
    local index = 7
    OptionRadar.super.new(self, name, icon, index)
end

function OptionRadar:goToScene()
    Terminal:hideAll()
    Terminal:getHidable("SceneRadar1"):show()
end