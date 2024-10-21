OptionProtected = Option:extend()

function OptionProtected:new()
    local name = "Protected"
    local icon = love.graphics.newImage("Icons/Protected.png")
    local index = 1
    OptionProtected.super.new(self, name, icon, index)
end

function OptionProtected:goToScene()
    Terminal:hideAll()
    Terminal:getHidables()["SceneProtected1"]:show()
end