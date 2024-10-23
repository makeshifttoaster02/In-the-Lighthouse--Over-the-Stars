Button = Object:extend()

function Button:new(x, y, text, fontSize)
    self.x = x
    self.y = y
    self.text = text

    self.fontSize = fontSize
    self.margin = Terminal:getHeight() / 40
    self.font = love.graphics.newFont("Fonts/Pinscher.otf", self.fontSize)

    self.width = self.font:getWidth(self.text) + 5 * self.margin
    self.height = self.font:getHeight() + 2 * self.margin
    self.radius = 5

    self.hovering = false
end

function Button:update(dt, cursorX, cursorY)
end

function Button:draw()
    love.graphics.setLineWidth(3)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height, self.radius)

    if self.hovering then
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.radius)
        local blackShader = Terminal:getInvertShader()
        love.graphics.setShader(blackShader)
    end

    love.graphics.printf(self.text, self.font, self.x, self.y + self.margin, self.width, "center")
    love.graphics.setShader()
end

function Button:mousereleased(cursorX, cursorY)
    love.errorhandler("Called Button:mousereleased from Abstract Button")
end

function Button:withinBounds(cursorX, cursorY)
    local canvasX = cursorX - Terminal:getX()
    local canvasY = cursorY - Terminal:getY()
    return self.x <= canvasX and canvasX <= self.x + self.width and self.y <= canvasY and canvasY <= self.y + self.height
end

function Button:markHovering(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        if not self.hovering then
            TEsound.play("Sounds/Hover.wav", "static")
        end
        self.hovering = true
    else
        self.hovering = false
    end
end

function Button:getWidth()
    return self.width
end

function Button:getHeight()
    return self.height
end

function Button:getX()
    return self.x
end

function Button:setX(x)
    self.x = x
end