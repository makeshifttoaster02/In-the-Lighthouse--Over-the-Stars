BackButton = Button:extend()

function BackButton:new(x, y, text, fontSize)
    BackButton.super.new(self, x, y, text, fontSize)
end

function BackButton:mousereleased(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        Terminal:hideAll()
        Terminal:getHidables()["Menu"]:show()
    end
end