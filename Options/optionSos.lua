OptionSos = Option:extend()

function OptionSos:new()
    local name = "SOS"
    local icon = love.graphics.newImage("Icons/Sos.png")
    local index = 7
    OptionSos.super.new(self, name, icon, index)
end

function OptionSos:goToScene()
    Terminal:hideAll()
    Terminal:getHidables()["SceneSos1"]:show()
end