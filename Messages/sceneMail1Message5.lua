SceneMail1Message5 = MailMessage:extend()

function SceneMail1Message5:new()
    local messageName = "SceneMail1Message5"
    local cantReply = false
    local cantReplyText = nil
    local text = [[[URGENT] Debris Spec
November 28, 2079
-------------
    
Hello,

This is Janice again.

As promised, here is the updated specifications for the debris: 

   Debris Type: Broken Satellite Solar Panel

   Size: ~ 4.56 Meters Long, 1.37 Meters Wide

   Velocity: ~ 23.68 km/s 

   Rotational Velocity: ~ 73.22 rpm

   Universal Interception Coordinates: 
   (139012.56, 2990117.68, 457812.90)

   Relative Interception Coordinates: 
   (37.21, 9.66, 1.56)

   Time of Retrieval: November 29, 2079 at 14:21

Once you have intercepted the debris, respond to this message with "Affirmative."

Thank you,

Janice Steele
Lighthouse Coordinator
IGSM
JNCSTL#499093]]
    SceneMail1Message5.super.new(self, text, cantReply, cantReplyText, messageName)
end