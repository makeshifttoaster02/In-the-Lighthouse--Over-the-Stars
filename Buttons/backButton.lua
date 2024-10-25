BackButton = Button:extend()

function BackButton:new(x, y, text, fontSize)
    BackButton.super.new(self, x, y, text, fontSize)
end

function BackButton:mousereleased(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        local currHidable = Terminal:getCurrHidable()
        if currHidable ~= nil and currHidable:isMailMessage() then
            Terminal:hideAll()
            Terminal:getHidable("SceneMail1"):show()
        else
            Terminal:hideAll()
            Terminal:getHidable("Menu"):show()
            Terminal:getHidable("SceneMail1"):resetScrollOffset()
        end
    end
end

function BackButton:draw()
    if not Terminal:getHidable("Menu"):isVisible() then
        BackButton.super.draw(self)
    end
end

function BackButton:markHovering(cursorX, cursorY)
    if not Terminal:getHidable("Menu"):isVisible() then
        BackButton.super.markHovering(self, cursorX, cursorY)
    end
end