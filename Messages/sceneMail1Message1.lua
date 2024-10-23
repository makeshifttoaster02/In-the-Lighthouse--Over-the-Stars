SceneMail1Message1 = MailMessage:extend()

function SceneMail1Message1:new()
    local text = [[Hello,

This is an automated message. 

Our systems have indicated your lighthouse contains a compromised power generator. Harmonic distortion in output voltage is causing the generator to overheat.

Please double check that the bearings of the generator are cleaned, lubricated, or replaced.

Thank you, 

IGSM]]
    SceneMail1Message1.super.new(self, text)
end