SceneSos3 = Hidable:extend()

function SceneSos3:new()
    self.icon = love.graphics.newImage("Icons/Question Mark.png")
    self.desiredIconLength = love.graphics.getHeight() / 7
    self.font = love.graphics.newFont("Fonts/Pinscher.otf", love.graphics.getHeight() / 20)
    self.text = "Couldn't find an access point. We'll keep trying."

    self.x = 0
    self.y = 0
    self.xIconMargin = Terminal:getWidth() / 10
    self.yIconMargin = Terminal:getHeight() / 2 - self.desiredIconLength / 2

    self.spaceMargin = Terminal:getWidth() / 10
    self.xTextMargin = self.xIconMargin + self.desiredIconLength + self.spaceMargin
    self.textWidth = Terminal:getWidth() - 2 * self.spaceMargin - self.xIconMargin - self.desiredIconLength
    local _, wrappedLines = self.font:getWrap(self.text, self.textWidth)
    self.textHeight = #wrappedLines * self.font:getHeight()
    self.yTextMargin = Terminal:getHeight() / 2 - self.textHeight / 2
end

function SceneSos3:update(dt, cursorX, cursorY)
end

function SceneSos3:draw()
    if self.visible then
        local iconSx = self.desiredIconLength / self.icon:getWidth()
        local iconSy = self.desiredIconLength / self.icon:getHeight()

        local iconX = self.x + self.xIconMargin
        local iconY = self.y + self.yIconMargin
        local textX = self.x + self.xTextMargin
        local textY = self.y + self.yTextMargin

        love.graphics.draw(self.icon, iconX, iconY, 0, iconSx, iconSy)
        love.graphics.printf(self.text, self.font, textX, textY, self.textWidth, "center")
    end
end

function SceneSos3:mousereleased(cursorX, cursorY)
end