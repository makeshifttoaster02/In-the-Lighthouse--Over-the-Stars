SceneMail1Entry3 = MailEntry:extend()

function SceneMail1Entry3:new()
    local title = "[URGENT] Debris Notice"
    local sender = "Janice"
    local date = "11/26/2079"
    local index = 3
    SceneMail1Entry3.super.new(self, title, sender, date, index)
end

function SceneMail1Entry3:mousereleased(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        Terminal:hideAll()
        Terminal:getHidable("SceneMail1Message3"):show()
    end
end
