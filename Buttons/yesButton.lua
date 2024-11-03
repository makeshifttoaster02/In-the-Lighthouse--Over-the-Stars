YesButton = Button:extend()

function YesButton:new()
    local x = DialogueBox:getBoxX() + DialogueBox:getBoxWidth() / 4
    local y = DialogueBox:getBoxY() + DialogueBox:getBoxHeight() * 3/5
    local fontSize = DialogueBox:getBoxFontSize()
    local text = "Yes"
    YesButton.super.new(self, x, y, text, fontSize)
    self:setNonTerminal()
end

function YesButton:mousereleased(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        DialogueBox:getCurrDialogueTree():trigger()
    end
end