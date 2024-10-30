MailEntry = Object:extend()

function MailEntry:new(title, sender, date, index)
    self.title = title
    self.sender = sender
    self.date = date
    self.index = index

    self.titleMargin = Terminal:getWidth() / 10
    self.titleFontSize = Terminal:getHeight() / 12
    self.otherFontSize = Terminal:getHeight() / 20

    self.titleFont = love.graphics.newFont("Fonts/Pinscher.otf", self.titleFontSize)
    self.otherFont = love.graphics.newFont("Fonts/Pinscher.otf", self.otherFontSize)

    self.margin = Terminal:getWidth() / 40
    self.width = Terminal:getWidth() - 2 * self.margin
    self.height = Terminal:getHeight() / 5

    self.x = self.margin
    self.desiredIconLength = Terminal:getHeight() / 10
    self.entry1margin = Terminal:getHeight() / 40
    self.entry1Y = self.desiredIconLength + self.entry1margin
    self.y = self.entry1Y + (self.margin + self.height) * (self.index - 1)
    self.radius = 5

    self.hovering = false

    self.desiredIconLength = self.titleFontSize
    self.icon = love.graphics.newImage("Icons/Read.png")
    self.iconMargin = self.margin * 2
end

function MailEntry:update(dt, cursorX, cursorY)
end

function MailEntry:draw()
    local scrollOffset = Terminal:getHidable("SceneMail1"):getScrollOffset()

    love.graphics.setLineWidth(4)
    love.graphics.rectangle("line", self.x, self.y - scrollOffset, self.width, self.height, self.radius)

    if self.hovering then
        love.graphics.rectangle("fill", self.x, self.y - scrollOffset, self.width, self.height, self.radius)
        local blackShader = Terminal:getInvertShader()
        love.graphics.setShader(blackShader)
    end

    local iconX = self.iconMargin * 1.5
    local iconY = self.y + self.height / 2 - self.titleFontSize / 2 - scrollOffset
    local iconSx = self.desiredIconLength / self.icon:getWidth()
    local iconSy = self.desiredIconLength / self.icon:getHeight()
    love.graphics.draw(self.icon, iconX, iconY, 0, iconSx, iconSy)

    local titleX = self.titleMargin + iconX
    local titleY = self.y + self.height / 2 - self.titleFontSize / 1.5 - scrollOffset
    love.graphics.print(self.title, self.titleFont, titleX, titleY)

    local dateText = "Date: " .. self.date
    local dateX = self.width - self.otherFont:getWidth(dateText) - self.titleMargin / 2
    local dateY = titleY - self.margin * 1/2

    local senderText = "Sender: " .. self.sender
    local senderX = self.width - self.otherFont:getWidth(senderText) - self.titleMargin / 2
    local senderY = self.y + self.height / 2 + self.otherFontSize / 3 - scrollOffset

    dateX = math.min(dateX, senderX)
    senderX = dateX

    love.graphics.print(dateText, self.otherFont, dateX, dateY)
    love.graphics.print(senderText, self.otherFont, senderX, senderY)

    love.graphics.setShader()
end

function MailEntry:withinBounds(cursorX, cursorY)
    local entryCursorX = Terminal:getX() + self.x - Game:getOffset()
    local entryCursorY = Terminal:getY() + self.y - Terminal:getHidable("SceneMail1"):getScrollOffset()
    return entryCursorX <= cursorX and cursorX <= entryCursorX + self.width and
            entryCursorY <= cursorY and cursorY <= entryCursorY + self.height
end

function MailEntry:markHovering(cursorX, cursorY)
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

function MailEntry:getHeight()
    return self.height
end

function MailEntry:getMargin()
    return self.margin
end

function MailEntry:getY()
    return self.y
end