SendButton = Button:extend()

function SendButton:new(x, y, text)
    local fontSize = Terminal:getHeight() / 30
    local icon = love.graphics.newImage("Icons/Send.png")
    SendButton.super.new(self, x, y, text, fontSize, icon)
end

function SendButton:mousereleased(cursorX, cursorY, messageName)
    if self:withinBounds(cursorX, cursorY) then
        Terminal:getHidable(messageName):setSending()
    end
end