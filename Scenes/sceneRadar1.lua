SceneRadar1 = Hidable:extend()

function SceneRadar1:new()
    self.youX = Terminal:getWidth() / 2
    self.youY = Terminal:getHeight() / 2
    self.youRadius = Terminal:getHeight() / 80
    
    self.radiusUnit = Terminal:getHeight() / 9.6
    self.numCircles = math.ceil(Terminal:getWidth() / self.radiusUnit)
    self.activeCircleIndex = 0

    self.activeCircleDuration = 0.5
    self.maxIndex = 15
    self.currActiveCircleDuration = 0

    self.margin = Terminal:getHeight() / 20
    self.boxX = self.margin
    self.boxY = self.margin
    self.boxWidth = Terminal:getWidth() - 2 * self.margin
    self.boxHeight = Terminal:getHeight() - 2 * self.margin

    self.drawYouHoverBox = false
    self.youHoverBoxMargin = Terminal:getHeight() / 20
    self.youHoverBoxTitle = "Lighthouse Unit 3A678D (You)"
    self.youHoverBoxText = [[Division 3099
Universal Coordinates: Failed to Retrieve]]
    self.youHoverBoxTitleFontSize = Terminal:getHeight() / 20
    self.youHoverBoxTextFontSize = Terminal:getHeight() / 25
    self.youHoverBoxTitleFont = love.graphics.newFont("Fonts/Pinscher.otf", self.youHoverBoxTitleFontSize)
    self.youHoverBoxTextFont = love.graphics.newFont("Fonts/Pinscher.otf", self.youHoverBoxTextFontSize)
    self.youHoverBoxWidth = self.youHoverBoxTextFont:getWidth(self.youHoverBoxText) + 2 * self.margin
    self.youHoverBoxHeight = self.youHoverBoxTitleFontSize + 2 * self.youHoverBoxTextFontSize + 3.5 * self.youHoverBoxMargin
    self.youHoverBoxRadius = 3
end

function SceneRadar1:update(dt, cursorX, cursorY)
    self.currActiveCircleDuration = self.currActiveCircleDuration + dt
    if self.currActiveCircleDuration >= self.activeCircleDuration then
        self.activeCircleIndex = self.activeCircleIndex + 1
        self.currActiveCircleDuration = 0
        if self.activeCircleIndex >= self.maxIndex then
            self.activeCircleIndex = 1
        end
    end

    self.drawYouHoverBox = self:withinYouBounds(cursorX, cursorY)
end

function SceneRadar1:draw()
    love.graphics.setScissor(self.boxX, self.boxY, self.boxWidth, self.boxHeight)
    love.graphics.setLineWidth(5)
    love.graphics.circle("fill", self.youX, self.youY, self.youRadius)
    love.graphics.setLineWidth(2)
    for i = 1, self.numCircles do
        SetColorHEX("#282828")
        if i == self.activeCircleIndex then
            SetColorHEX("#FFFFFF")
        end
        love.graphics.circle("line", self.youX, self.youY, self.radiusUnit * i)
        SetColorHEX("#FFFFFF")
    end
    if self.drawYouHoverBox then
        SetColorHEX("#000000")
        love.graphics.rectangle("fill", self.youX, self.youY, self.youHoverBoxWidth, self.youHoverBoxHeight, self.youHoverBoxRadius)

        SetColorHEX("#FFFFFF")
        love.graphics.rectangle("line", self.youX, self.youY, self.youHoverBoxWidth, self.youHoverBoxHeight, self.youHoverBoxRadius)

        love.graphics.printf(self.youHoverBoxTitle, self.youHoverBoxTitleFont, self.youX + self.youHoverBoxMargin, self.youY + self.youHoverBoxMargin, self.youHoverBoxWidth - 2 * self.margin, "left")
        love.graphics.printf(self.youHoverBoxText, self.youHoverBoxTextFont, self.youX + self.youHoverBoxMargin, self.youY + self.youHoverBoxMargin * 2 + self.youHoverBoxTitleFontSize, self.youHoverBoxWidth - 2 * self.margin, "left")       
    end
    love.graphics.rectangle("line", self.boxX, self.boxY, self.boxWidth - 2, self.boxHeight - 2)
    love.graphics.setScissor()
end

function SceneRadar1:withinYouBounds(cursorX, cursorY)
    local canvasX = cursorX - Terminal:getX()
    local canvasY = cursorY - Terminal:getY()
    return self.youX - self.youRadius <= canvasX and canvasX <= self.youX + self.youRadius and self.youY - self.youRadius <= canvasY and canvasY <= self.youY + self.youRadius
end