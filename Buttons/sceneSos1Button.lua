SceneSos1Button = Button:extend()

function SceneSos1Button:new(x, y, text)
    local fontSize = Terminal:getHeight() / 10
    SceneSos1Button.super.new(self, x, y, text, fontSize)
end

function SceneSos1Button:mousereleased(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        Terminal:hideAll()
        Terminal:getHidables()["SceneSos2"]:show()
    end
end