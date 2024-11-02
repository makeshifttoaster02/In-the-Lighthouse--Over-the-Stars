SceneMail1Message6 = MailMessage:extend()

function SceneMail1Message6:new()
    local messageName = "SceneMail1Message6"
    local cantReply = true
    local cantReplyText = ""
    local text = [[(no subject)
January 16, 2085
-------------
    
To Daniel Stefan Moreno,

If you are reading this message, it means your lighthouse was at some point within proximity to our search and rescue spacecrafts. We have had tremendous difficulty locating you due to a malfunctioning positional system.

A little over five years ago, you were the victim of a jettison accident. Criminals were attempting to dispose of metallic uranium waste into space. The waste collided with our spacecraft, causing a nuclear explosion and sending all nearby lighthouses flying into the void.

Since then, we've apprehended the offenders and made sweeping changes to our space disposal policies. In other words, you were the seeds of change. For all intents and purposes, you are a hero. And on a personal note, I am sorry that it is only after tragedy occurs that humanity enacts change.

But with a heavy heart, we regret to inform you that we must suspend our search operation. A nearby star is on the verge of collapse, and for the safety of our search team, we must pull back.

In anticipation, we have made all necessary arrangements in accordance with the information on your will. Additionally, we have asked all loved ones listed on your contact for any parting words they would like to pass on. We have attached them to the bottom of this message.

We know that no amount of apology could ever be enough. Once again, man's presumptuous disposition towards manifest destiny and the right to space has claimed yet another innocent life.

On behalf of everyone at the Intergalactic Space Ministry, we bow our heads in grief and silence.

Reina White
Chief Operating Officer
IGSM
REINAW#235477]]
    SceneMail1Message6.super.new(self, text, cantReply, cantReplyText, messageName)
end