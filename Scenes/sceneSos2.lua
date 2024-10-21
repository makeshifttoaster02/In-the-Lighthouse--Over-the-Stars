SceneSos2 = Hidable:extend()

function SceneSos2:new()
    self.icon = love.graphics.newImage("Icons/Satelite.png")
    self.desiredIconLength = love.graphics.getHeight() / 7
    self.font = love.graphics.newFont("Fonts/Pinscher.otf", love.graphics.getHeight() / 20)
    self.text = "Searching for nearest SOS access point "
    self.periodText = "."

    self.x = Terminal:getX()
    self.y = Terminal:getY()
    self.xIconMargin = Terminal:getWidth() / 10
    self.yIconMargin = Terminal:getHeight() / 2 - self.desiredIconLength / 2

    self.spaceMargin = Terminal:getWidth() / 10
    self.xTextMargin = self.xIconMargin + self.desiredIconLength + self.spaceMargin
    self.textWidth = Terminal:getWidth() - 2 * self.spaceMargin - self.xIconMargin - self.desiredIconLength
    local _, wrappedLines = self.font:getWrap(self.text, self.textWidth)
    self.textHeight = #wrappedLines * self.font:getHeight()
    self.yTextMargin = Terminal:getHeight() / 2 - self.textHeight / 2

    self.periodTextUpdateDuration = 0.7
    self.sceneUpdateDuration = math.random(7, 15)
    self.currPeriodDuration = 0
    self.currSceneDuration = 0
end

function SceneSos2:update(dt, cursorX, cursorY)
    self.currPeriodDuration = self.currPeriodDuration + dt
    if self.currPeriodDuration >= self.periodTextUpdateDuration then
        self.currPeriodDuration = 0
        self.periodText = self.periodText .. "."
        if self.periodText == "...." then
            self.periodText = "."
        end
    end

    self.currSceneDuration = self.currSceneDuration + dt
    if self.currSceneDuration >= self.sceneUpdateDuration then
        Terminal:hideAll()
        Terminal:getHidables()["SceneSos3"]:show()
    end
end

function SceneSos2:draw()
    if self.visible then
        local iconSx = self.desiredIconLength / self.icon:getWidth()
        local iconSy = self.desiredIconLength / self.icon:getHeight()

        local iconX = self.x + self.xIconMargin
        local iconY = self.y + self.yIconMargin
        local textX = self.x + self.xTextMargin
        local textY = self.y + self.yTextMargin

        love.graphics.draw(self.icon, iconX, iconY, 0, iconSx, iconSy)
        love.graphics.printf(self.text .. self.periodText, self.font, textX, textY, self.textWidth, "center")
    end
end

function SceneSos2:mousereleased(cursorX, cursorY)
end

function SceneSos2:restoreDefaults()
    self.sceneUpdateDuration = math.random(7, 15)
    self.currPeriodDuration = 0
    self.currSceneDuration = 0
    self.periodText = "."
end