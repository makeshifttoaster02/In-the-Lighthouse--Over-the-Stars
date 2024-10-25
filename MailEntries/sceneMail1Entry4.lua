SceneMail1Entry4 = MailEntry:extend()

function SceneMail1Entry4:new()
    local title = "Call us when you can"
    local sender = "Gael"
    local date = "11/27/2079"
    local index = 2
    SceneMail1Entry3.super.new(self, title, sender, date, index)
end

function SceneMail1Entry4:mousereleased(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        Terminal:hideAll()
        Terminal:getHidable("SceneMail1Message4"):show()
    end
end
