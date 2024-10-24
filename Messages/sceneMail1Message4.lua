SceneMail1Message4 = MailMessage:extend()

function SceneMail1Message4:new()
    local cantReply = "False"
    local cantReplyText = nil
    local text = [[Call us when you can
November 27, 2079
-------------
    
Hey Dan,

I know you're busy out there and making it to a docking station can be hard, but please find the time to give us a call.

Nana hasn't been feeling super well recently. This was the first Thanksgiving she spent alone. She really misses you.

Gael]]
    SceneMail1Message4.super.new(self, text, cantReply, cantReplyText)
end