MailMessage = Hidable:extend()

function MailMessage:new(text, reply, cantReply, cantReplyText)
    self.text = text
    self.reply = reply or nil
    self.cantReply = cantReply
    self.cantReplyText = cantReplyText

    self.fontSize = Terminal:getHeight() / 15
    self.font = love.graphics.newFont("Fonts/Pinscher.otf", self.fontSize)

    self.upArrow = love.graphics.newImage("Icons/UpArrow.png")
    self.downArrow = love.graphics.newImage("Icons/DownArrow.png")
    self.desiredIconLength = Terminal:getHeight() / 10

    self.margin = Terminal:getHeight() / 20
    self.x = 2 * self.margin
    self.y = 3 * self.margin
    self.width = Terminal:getWidth() - 4 * self.margin

    self.textboxX = self.x
    self.textboxY = self.y
    self.textboxWidth = self.width
    self.textboxHeight = Terminal:getHeight() - 2 * self.desiredIconLength - 2 * self.margin

    self.scrollVelocity = self.margin
    self.scrollOffset = 0
    self.minScrollOffset = 0
    local _, wrappedText = self.font:getWrap(self.text, self.textboxWidth)
    local totalTextHeight = self.font:getHeight() * #wrappedText
    self.maxScrollOffset = totalTextHeight - self.textboxHeight

    self.showUpArrow = false
    self.showDownArrow = true

end

function MailMessage:update(dt, cursorX, cursorY)
    self.showUpArrow = self.scrollOffset > self.minScrollOffset
    self.showDownArrow = self.scrollOffset < self.maxScrollOffset
end

function MailMessage:draw()
    if self.visible then
        local textY = self.y - self.scrollOffset
        love.graphics.setScissor(self.textboxX, self.textboxY, self.textboxWidth, self.textboxHeight)
        love.graphics.printf(self.text, self.font, self.x, textY, self.width, "left")
        love.graphics.setScissor()

        if self.showUpArrow then
            local upSx = self.desiredIconLength / self.upArrow:getWidth()
            local upSy = self.desiredIconLength / self.upArrow:getHeight()
            local upX = Terminal:getWidth() / 2 - self.desiredIconLength / 2
            local upY = self.textboxY - self.desiredIconLength - self.margin * 1/2
            love.graphics.draw(self.upArrow, upX, upY, 0, upSx, upSy)
        end

        if self.showDownArrow then
            local downSx = self.desiredIconLength / self.downArrow:getWidth()
            local downSy = self.desiredIconLength / self.downArrow:getHeight()
            local downX = Terminal:getWidth() / 2 - self.desiredIconLength / 2
            local downY = self.textboxY + self.textboxHeight + self.margin * 1/2
            love.graphics.draw(self.downArrow, downX, downY, 0, downSx, downSy)
        end

    end
end

function MailMessage:wheelmoved(y)
    if y > 0 then
        self.scrollOffset = math.max(self.minScrollOffset, self.scrollOffset - y * self.scrollVelocity)
    else
        self.scrollOffset = math.min(self.scrollOffset - y * self.scrollVelocity, self.maxScrollOffset)
    end
end

function MailMessage:keypressed(key)
    if key == "up" or key == "w" then
        self:wheelmoved(1)
    elseif key == "down" or key == "s" then
        self:wheelmoved(-1)
    end
end

function MailMessage:isMailMessage()
    return true
end

function MailMessage:restoreDefaults()
    self.scrollOffset = 0
end