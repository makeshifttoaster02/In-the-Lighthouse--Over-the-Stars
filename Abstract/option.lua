Option = Object:extend()

function Option:new(name, icon, index)
    self.name = name
    self.icon = icon
    self.index = index

    self.desiredIconLength = love.graphics.getHeight() / 20
    self.margin = self.desiredIconLength / 4
    self.optionHeight = self.desiredIconLength + 2 * self.margin
    self.optionWidth = Terminal:getWidth()

    self.hovering = false

    self.x = Terminal:getX()
    self.y = Terminal:getY() + (self.index - 1) * self.desiredIconLength
end

function Option:update(dt)

end

function Option:draw()
    local iconSx = self.desiredIconLength / self.icon:getWidth()
    local iconSy = self.desiredIconLength / self.icon:getHeight()

    local font = love.graphics.newFont("Fonts/Pinscher.otf", self.desiredIconLength)

    local iconX = self.x + self.margin
    local iconY = self.y + self.margin
    local textX = self.x + self.margin + (self.desiredIconLength + self.margin)
    local textY = self.y + self.margin

    if self.hovering then
        love.graphics.rectangle("fill", self.x, self.y, self.optionWidth, self.optionHeight)

        local blackShader = love.graphics.newShader(love.filesystem.read("Shaders/convertToBlack.glsl"))
        love.graphics.setShader(blackShader)
    end

    love.graphics.draw(self.icon, iconX, iconY, 0, iconSx, iconSy)
    love.graphics.print(self.name, font, textX, textY)
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
    return self.x <= cursorX and cursorX <= self.x + self.optionWidth and self.y <= cursorY and cursorY <= self.y + self.optionHeight
end

function Option:goToScene()
    Terminal:hideAll()
end

function Option:__tostring()
    return "Option " .. self.name
end