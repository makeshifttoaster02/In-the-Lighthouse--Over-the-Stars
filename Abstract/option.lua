Option = Object:extend()

function Option:new(name, icon, index)
    self.name = name
    self.icon = icon
    self.index = index

    self.desiredIconLength = love.graphics.getHeight() / 25
    self.iconMargin = self.desiredIconLength / 2
    self.textMargin = self.desiredIconLength / 3
    self.optionHeight = self.desiredIconLength + 2 * self.textMargin
    self.optionWidth = Terminal:getWidth()

    self.hovering = false

    self.x = 0
    self.y = (self.index - 1) * self.desiredIconLength
    self.font = love.graphics.newFont("Fonts/Pinscher.otf", self.desiredIconLength)
end

function Option:update(dt)

end

function Option:draw()
    local iconSx = self.desiredIconLength / self.icon:getWidth()
    local iconSy = self.desiredIconLength / self.icon:getHeight()

    local iconX = self.x + self.iconMargin
    local iconY = self.y + self.iconMargin
    local textX = self.x + self.iconMargin + (self.desiredIconLength + self.textMargin)
    local textY = self.y + self.iconMargin

    if self.hovering then
        love.graphics.rectangle("fill", self.x, self.y + self.iconMargin - self.textMargin, self.optionWidth, self.optionHeight)

        local blackShader = Terminal:getInvertShader()
        love.graphics.setShader(blackShader)
    end

    love.graphics.draw(self.icon, iconX, iconY, 0, iconSx, iconSy)
    love.graphics.print(self.name, self.font, textX, textY)
    love.graphics.setShader()
end

function Option:markHovering(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        if not self.hovering then
            TEsound.play("Sounds/Hover.wav", "static")
        end
        self.hovering = true
    else
        self.hovering = false
    end
end

function Option:withinBounds(cursorX, cursorY)
    local canvasX = cursorX - Terminal:getX()
    local canvasY = cursorY - Terminal:getY()
    return self.x <= canvasX and canvasX <= self.x + self.optionWidth and self.y <= canvasY and canvasY <= self.y + self.optionHeight
end

function Option:goToScene()
    Terminal:hideAll()
end

function Option:__tostring()
    return "Option " .. self.name
end