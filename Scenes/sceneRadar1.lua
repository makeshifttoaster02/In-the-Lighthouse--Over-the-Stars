SceneRadar1 = Hidable:extend()

function SceneRadar1:new()
    self.youX = Terminal:getWidth() / 2
    self.youY = Terminal:getHeight() / 2
    self.youRadius = Terminal:getHeight() / 80
    self.youMargin = Terminal:getHeight() / 80
    self.youText = "You"
    self.youFontSize = Terminal:getHeight() / 25
    self.youFont = love.graphics.newFont("Fonts/Pinscher.otf", self.youFontSize)
    self.youTextX = self.youX + self.youRadius + self.youMargin
    self.youTextY = self.youY - self.youRadius - self.youFontSize - self.youMargin
    
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

    self.warningIcon1 = love.graphics.newImage("Icons/Exclamation.png")
    self.warningIcon2 = love.graphics.newImage("Icons/Exclamation 2.png")
    self.warningIcon3 = love.graphics.newImage("Icons/Exclamation 3.png")
    self.warningX = self.boxX + self.boxWidth / 6
    self.warningY = self.boxY + self.boxHeight / 6
    self.warningDesiredLength = Terminal:getHeight() / 25
    self.warningMargin = Terminal:getHeight() / 50
    self.warningRadius = self.warningDesiredLength / 2 + self.warningMargin

    self.drawWarningHoverBox = false
    self.warningHoverBoxMargin = Terminal:getHeight() / 20
    self.warningHoverBoxTitle = "ALERT"
    self.warningHoverBoxText = [[High iron density detected.
    
Contact your lighthouse coordinator for more details.]]
    self.warningHoverBoxTitle2 = "WARNING"
    self.warningHoverBoxText2 = [[Early stages of star collapse detected, including radiation.
    
Limit exposure.]]
    self.warningHoverBoxTitle3 = "CRITICAL"
    self.warningHoverBoxText3 = [[Type II supernova inbound. Evacuate immediately.]]
    self.warningHoverBoxTitleFontSize = Terminal:getHeight() / 20
    self.warningHoverBoxTextFontSize = Terminal:getHeight() / 25
    self.warningHoverBoxTitleFont = love.graphics.newFont("Fonts/Pinscher.otf", self.warningHoverBoxTitleFontSize)
    self.warningHoverBoxTextFont = love.graphics.newFont("Fonts/Pinscher.otf", self.warningHoverBoxTextFontSize)
    self.warningHoverBoxWidth = self.youHoverBoxWidth
    self.warningHoverBoxHeight = self.warningHoverBoxTitleFontSize + 4 * self.warningHoverBoxTextFontSize + 3.5 * self.warningHoverBoxMargin
    self.warningHoverBoxRadius = 3

    self.isDay34 = false
    self.isDay56 = false
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
    self.drawWarningHoverBox = self:withinWarningBounds(cursorX, cursorY)
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
    love.graphics.print(self.youText, self.youFont, self.youTextX, self.youTextY)
    love.graphics.rectangle("line", self.boxX, self.boxY, self.boxWidth - 2, self.boxHeight - 2)

    SetColorHEX("#000000")
    love.graphics.circle("fill", self.warningX + self.warningDesiredLength / 2, self.warningY + self.warningDesiredLength / 2, self.warningDesiredLength / 2 + self.warningMargin)
    SetColorHEX("#FFFFFF")
    local day = DayManager:getDay()
    local warningIcon = self.warningIcon1
    if self.isDay34 then
        warningIcon = self.warningIcon2
        love.graphics.setShader(Game:getYellowShader())
    elseif self.isDay56 then
        warningIcon = self.warningIcon3
        love.graphics.setShader(Game:getRedShader())
    end
    local warningSx = self.warningDesiredLength / warningIcon:getWidth()
    local warningSy = self.warningDesiredLength / warningIcon:getHeight()
    love.graphics.circle("line", self.warningX + self.warningDesiredLength / 2, self.warningY + self.warningDesiredLength / 2, self.warningDesiredLength / 2 + self.warningMargin)
    love.graphics.draw(warningIcon, self.warningX, self.warningY, 0, warningSx, warningSy)
    love.graphics.setShader()

    if self.drawWarningHoverBox then
        local hoverTitle = self.warningHoverBoxTitle
        local hoverText = self.warningHoverBoxText
        if day == 3 or day == 4 then
            hoverTitle = self.warningHoverBoxTitle2
            hoverText = self.warningHoverBoxText2
        elseif day == 5 or day == 6 then
            hoverTitle = self.warningHoverBoxTitle3
            hoverText = self.warningHoverBoxText3
        end

        local centerWarningX = self.warningX + self.warningDesiredLength / 2
        local centerWarningY = self.warningY + self.warningDesiredLength / 2

        SetColorHEX("#000000")
        love.graphics.rectangle("fill", centerWarningX, centerWarningY, self.warningHoverBoxWidth, self.warningHoverBoxHeight, self.warningHoverBoxRadius)

        SetColorHEX("#FFFFFF")
        love.graphics.rectangle("line", centerWarningX, centerWarningY, self.warningHoverBoxWidth, self.warningHoverBoxHeight, self.warningHoverBoxRadius)

        love.graphics.printf(hoverTitle, self.warningHoverBoxTitleFont, centerWarningX + self.warningHoverBoxMargin, centerWarningY + self.warningHoverBoxMargin, self.warningHoverBoxWidth - 2 * self.margin, "left")
        love.graphics.printf(hoverText, self.warningHoverBoxTextFont, centerWarningX + self.warningHoverBoxMargin, centerWarningY + self.warningHoverBoxMargin * 2 + self.warningHoverBoxTitleFontSize, self.warningHoverBoxWidth - 2 * self.margin, "left")
    end

    love.graphics.setScissor()
    love.graphics.setShader()

    SetColorHEX("#FFFFFF")
end

function SceneRadar1:withinYouBounds(cursorX, cursorY)
    local youCursorX = Terminal:getX() + self.youX - OffsetManager:getOffset()
    local youCursorY = Terminal:getY() + self.youY
    return youCursorX - self.youRadius <= cursorX and cursorX <= youCursorX + self.youRadius and youCursorY - self.youRadius <= cursorY and cursorY <= youCursorY + self.youRadius
end

function SceneRadar1:withinWarningBounds(cursorX, cursorY)
    local warningCursorX = Terminal:getX() + self.warningX - OffsetManager:getOffset()
    local warningCursorY = Terminal:getY() + self.warningY
    return warningCursorX <= cursorX and cursorX <= warningCursorX + self.warningRadius * 2 and warningCursorY <= cursorY and cursorY <= warningCursorY + self.warningRadius * 2
end

function SceneRadar1:triggerDay34()
    self.isDay34 = true
    self.isDay56 = false
end

function SceneRadar1:triggerDay56()
    self.isDay34 = false
    self.isDay56 = true
end