OptionRadar = Option:extend()

function OptionRadar:new()
    local name = "Radar"
    local icon = love.graphics.newImage("Icons/Radar.png")
    local index = 5.5
    OptionRadar.super.new(self, name, icon, index)
end