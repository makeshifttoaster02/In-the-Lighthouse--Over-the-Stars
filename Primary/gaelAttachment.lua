GaelAttachment = Object:extend()

function GaelAttachment:new()
    self.title = "Gael Moreno"
    self.icon = love.graphics.newImage("Icons/Document.png")
    self.margin = Terminal:getWidth() / 40
    self.height = Terminal:getHeight() / 6
    self.width = Terminal:getWidth() / 2.5
    self.desiredIconLength = Terminal:getHeight() / 12
    self.titleFontSize = self.desiredIconLength - 2
    self.titleFont = love.graphics.newFont("Fonts/Pinscher.otf", self.titleFontSize)
    self.radius = 5

    self.iconMargin = (self.height - self.desiredIconLength) / 2
    self.iconX = self.iconMargin
    self.iconY = self.iconMargin

    self.titleX = self.iconX + self.desiredIconLength + self.iconMargin
    self.titleY = self.iconY * 3/4

    self.hovering = false
end

function GaelAttachment:draw()
    love.graphics.setLineWidth(4)
    local attachmentX = Terminal:getWidth() / 2 - self.width / 2
    local attachmentY = Terminal:getHidable("SceneMail1Message6"):getGaelY()
    love.graphics.rectangle("line", attachmentX, attachmentY, self.width, self.height, self.radius)

    if self.hovering then
        love.graphics.rectangle("fill", attachmentX, attachmentY, self.width, self.height, self.radius) 
        local blackShader = Terminal:getInvertShader()
        love.graphics.setShader(blackShader)
    end

    local iconSx = self.desiredIconLength / self.icon:getWidth()
    local iconSy = self.desiredIconLength / self.icon:getHeight()
    love.graphics.draw(self.icon, attachmentX + self.iconX, attachmentY + self.iconY, 0, iconSx, iconSy)
    love.graphics.print(self.title, self.titleFont, attachmentX + self.titleX, attachmentY + self.titleY)
    love.graphics.setShader()
end

function GaelAttachment:mousereleased(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        Terminal:hideAll()
        Terminal:getHidable("SceneMail1Message7"):show()
    end
end

function GaelAttachment:markHovering(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) and not DialogueBox:isVisible() then
        if not self.hovering then
            TEsound.play("Sounds/Hover.wav", "static")
        end
        self.hovering = true
        Game:setHovering()
    else
        self.hovering = false
    end
end

function GaelAttachment:withinBounds(cursorX, cursorY)
    local attachmentX = Terminal:getWidth() / 2 - self.width / 2
    local attachmentY = Terminal:getHidable("SceneMail1Message6"):getGaelY()
    local attachmentCursorX = Terminal:getX() + attachmentX - OffsetManager:getOffset()
    local attachmentCursorY = Terminal:getY() + attachmentY
    return attachmentCursorX <= cursorX and cursorX <= attachmentCursorX + self.width and
            attachmentCursorY <= cursorY and cursorY <= attachmentCursorY + self.height
end

function GaelAttachment:getHeight()
    return self.height
end

function GaelAttachment:getMargin()
    return self.margin
end