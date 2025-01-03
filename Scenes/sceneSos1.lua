SceneSos1 = Hidable:extend()

function SceneSos1:new()
    self.icon = love.graphics.newImage("Icons/Wifi.png")
    self.desiredIconLength = love.graphics.getHeight() / 10
    self.font = love.graphics.newFont("Fonts/Pinscher.otf", Terminal:getHeight() / 5)

    self.questionText = "Send SOS?"

    self.x = 0
    self.y = 0
    self.spaceMargin = Terminal:getWidth() / 20
    self.xMargin = (Terminal:getWidth() - self.desiredIconLength - self.spaceMargin - self.font:getWidth(self.questionText)) / 2
    self.yMargin = Terminal:getHeight() / 8

    local buttonX = self.x + self.xMargin
    local buttonY = self.y + Terminal:getHeight() - self.yMargin - self.desiredIconLength
    local buttonText = "Yes"
    self.button = SceneSos1Button(buttonX, buttonY, buttonText)
    self.button:setX((Terminal:getWidth() - self.button:getWidth()) / 2)
end

function SceneSos1:update(dt, cursorX, cursorY)
    if self.visible then
        self.button:markHovering(cursorX, cursorY)
    end
end

function SceneSos1:draw()
    if self.visible then
        local iconSx = self.desiredIconLength / self.icon:getWidth()
        local iconSy = self.desiredIconLength / self.icon:getHeight()

        local iconX = self.x + self.xMargin
        local iconY = self.y + self.yMargin
        local textX = self.x + self.xMargin + self.desiredIconLength + self.spaceMargin
        local textY = self.y + self.yMargin

        love.graphics.draw(self.icon, iconX, iconY, 0, iconSx, iconSy)
        love.graphics.print(self.questionText, self.font, textX, textY)
        self.button:draw()
    end
end

function SceneSos1:mousereleased(cursorX, cursorY)
    if self.button:withinBounds(cursorX, cursorY) then
        self.button:mousereleased(cursorX, cursorY)
    end
end