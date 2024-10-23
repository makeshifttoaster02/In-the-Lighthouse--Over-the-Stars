SceneMail1Entry5 = MailEntry:extend()

function SceneMail1Entry5:new()
    local title = "[URGENT] Debris Spec"
    local sender = "Janice"
    local date = "11/28/2079"
    local index = 5
    SceneMail1Entry3.super.new(self, title, sender, date, index)
end

function SceneMail1Entry5:mousereleased(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        Terminal:hideAll()
        Terminal:getHidable("SceneMail1Message5"):show()
    end
end
