OptionRadar = Option:extend()

function OptionRadar:new()
    local name = "Radar"
    local icon = love.graphics.newImage("Icons/Radar.png")
    local index = 3
    OptionRadar.super.new(self, name, icon, index)
end

function OptionRadar:goToScene()
    Terminal:hideAll()
    local radarScene = Terminal:getHidable("SceneRadar1")
    radarScene:show()
    if radarScene:isDay4Phase1() then
        radarScene:triggerDay4Phase2()
    elseif radarScene:isDay4Phase2() and radarScene:isRescueDisappear() then
        radarScene:triggerDay4Phase3()
    end
end