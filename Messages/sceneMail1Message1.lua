SceneMail1Message1 = MailMessage:extend()

function SceneMail1Message1:new()
    local cantReply = true
    local cantReplyText = "This sender is not accepting replies."
    local text = [[[URGENT] Generator Repair
November 21, 2079
-------------
    
Hello,

This is an automated message. 

Our systems have indicated your lighthouse contains a compromised power generator. Harmonic distortion in output voltage is causing the generator to overheat.

Please double check that the bearings of the generator are cleaned, lubricated, or replaced.

Thank you, 

IGSM]]
    SceneMail1Message1.super.new(self, text, cantReply, cantReplyText)
end