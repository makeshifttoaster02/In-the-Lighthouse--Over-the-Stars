NoButton = Button:extend()

function NoButton:new()
    local x = DialogueBox:getBoxX() + DialogueBox:getBoxWidth() * 3/4
    local y = DialogueBox:getBoxY() + DialogueBox:getBoxHeight() * 3/5
    local fontSize = DialogueBox:getBoxFontSize()
    local text = "No"
    NoButton.super.new(self, x, y, text, fontSize)
    self:setX(self:getX() - self:getWidth())
    self:setNonTerminal()
end

function NoButton:mousereleased(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        DialogueBox:getCurrDialogueTree():escape()
    end
end