SceneMail1Entry2 = MailEntry:extend()

function SceneMail1Entry2:new()
    local title = "[URGENT] Cooling Replace"
    local sender = "IGSM"
    local date = "11/23/2079"
    local index = 2
    SceneMail1Entry2.super.new(self, title, sender, date, index)
end

function SceneMail1Entry2:mousereleased(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        Terminal:hideAll()
        Terminal:getHidable("SceneMail1Message2"):show()
    end
end
