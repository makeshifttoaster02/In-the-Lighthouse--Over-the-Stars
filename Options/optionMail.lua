OptionMail = Option:extend()

function OptionMail:new()
    local name = "Mail"
    local icon = love.graphics.newImage("Icons/Mail.png")
    local index = 5
    OptionMail.super.new(self, name, icon, index)
end

function OptionMail:goToScene()
    Terminal:hideAll()
    Terminal:getHidables()["SceneMail1"]:show()
end