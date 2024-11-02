SceneMail1Message7 = MailMessage:extend()

function SceneMail1Message7:new()
    local messageName = "SceneMail1Message7"
    local cantReply = true
    local cantReplyText = ""
    local text = [[Hey Dan,

Last year, Nana passed away. It was during my final year of aeronautics engineering school. She died alone.

I remember how I always dreamed of going to space. Those dreams seem so small in comparison now. Space was always going to be there to explore. Nana wasn't. Why didn't I call more? Why didn't I visit more? Nana never scolded us - all she ever wanted to do was talk.

It's true that we don't appreciate what we have until it's gone. But I think it's also true that we spend our lives searching for the next big thing, as if life wasn't good enough.

That's why I'm determined not to lose you too, Dan. So I'll go find you. I'll come visit you. We'll laugh about the old days, catch up on the new.

So promise me you won't be sad, okay?
Promise me you won't cry, okay?
We're small people with big hearts.
We love each other - this is our art.
And just like how we made our home under that tree all those years ago, we'll make a new home, together in the ether.

I'll see you soon.
This isn't a goodbye, this is a thank you.

I love you so much.

Gael]]
    SceneMail1Message7.super.new(self, text, cantReply, cantReplyText, messageName)
end