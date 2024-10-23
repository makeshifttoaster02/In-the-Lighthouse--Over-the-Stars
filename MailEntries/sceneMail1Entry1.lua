SceneMail1Entry1 = MailEntry:extend()

function SceneMail1Entry1:new()
    local title = "[URGENT] Generator Repair"
    local sender = "IGSM"
    local date = "11/21/2079"
    local index = 1
    SceneMail1Entry1.super.new(self, title, sender, date, index)
end

function SceneMail1Entry1:mousereleased(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        Terminal:hideAll()
        Terminal:getHidable("SceneMail1Message1"):show()
    end
end
