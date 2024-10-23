SceneMail1Message3 = MailMessage:extend()

function SceneMail1Message3:new()
    local text = [[Hello,

This is Janice from the Intergalactic Space Ministry. I am the leader of your lighthouse division.

This email is to inform you of an upcoming debris retrieval project. Here are some of the known parameters:

   Debris Type: Broken Satellite Solar Panel

   Size: ~ 4.7 Meters Long, 1.3 Meters Wide

   Velocity: ~ 25 km/s 

   Estimated Time of Retrieval: November 29, 2079 at ~ 11:30

No action is needed at this time. Expect more details as we get closer to retrieval date.

Thank you,

Janice Steele
Lighthouse Coordinator
IGSM
JNCSTL#499093]]
    SceneMail1Message3.super.new(self, text)
end