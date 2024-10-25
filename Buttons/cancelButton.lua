CancelButton = Button:extend()

function CancelButton:new(x, y, text)
    local fontSize = Terminal:getHeight() / 30
    local icon = love.graphics.newImage("Icons/Cancel.png")
    CancelButton.super.new(self, x, y, text, fontSize, icon)
end

function CancelButton:mousereleased(cursorX, cursorY, messageName)
    if self:withinBounds(cursorX, cursorY) then
        Terminal:getHidable(messageName):deactivateReplyInput()
        Terminal:getHidable(messageName):setToMaxOffset()
    end
end