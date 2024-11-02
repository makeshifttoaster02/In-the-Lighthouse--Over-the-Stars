SceneMail1Entry6 = MailEntry:extend()

function SceneMail1Entry6:new()
    local title = "(no subject)"
    local sender = "Reina"
    local date = "01/16/2085"
    local index = 1
    SceneMail1Entry6.super.new(self, title, sender, date, index)
end

function SceneMail1Entry6:mousereleased(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        Terminal:hideAll()
        Terminal:getHidable("SceneMail1Message6"):show()
    end
end
