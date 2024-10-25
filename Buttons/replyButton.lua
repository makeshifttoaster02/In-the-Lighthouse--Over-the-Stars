ReplyButton = Button:extend()

function ReplyButton:new(x, y, text)
    local fontSize = Terminal:getHeight() / 30
    local icon = love.graphics.newImage("Icons/Reply.png")
    ReplyButton.super.new(self, x, y, text, fontSize, icon)

    self.visible = true
end

function ReplyButton:mousereleased(cursorX, cursorY, messageName)
    if self:withinBounds(cursorX, cursorY) then
        self:hide()
        Terminal:getHidable(messageName):setToMaxOffset()
        Terminal:getHidable(messageName):activateReplyInput()
    end
end

function ReplyButton:isVisible()
    return self.visible
end

function ReplyButton:show()
    self.visible = true
end

function ReplyButton:hide()
    self.visible = false
end