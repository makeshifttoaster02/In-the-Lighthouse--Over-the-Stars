SceneMail1Entry1 = MailEntry:extend()

function SceneMail1Entry1:new()
    local title = "Generator Repair"
    local sender = "IGSM"
    local date = "05/17/2083"
    local index = 1
    SceneMail1Entry1.super.new(self, title, sender, date, index)
end

