SceneMail1Message2 = MailMessage:extend()

function SceneMail1Message2:new()
    local cantReply = true
    local cantReplyText = "This sender is not accepting replies."
    local text = [[[URGENT] Cooling Replace
November 23, 2079
-------------
    
Hello,

This is an automated message. 

Our systems have indicated your lighthouse contains a faulty cooling infrastructure. This can be for a number of reasons, ranging from pump failure, degraded insulation materials, or corroded heat exchangers, all of which can lead to thermal hotspots.

Please double check that all cooling passages are unblocked and replace any necessary parts in both the air and liquid cooling generators.

Thank you, 

IGSM]]
    SceneMail1Message2.super.new(self, text, cantReply, cantReplyText)
end