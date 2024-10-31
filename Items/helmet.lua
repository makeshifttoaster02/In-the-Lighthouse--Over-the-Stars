Helmet = Item:extend()

function Helmet:new()
    local images = {
        love.graphics.newImage("Assets/Helmet 1.png"),
        love.graphics.newImage("Assets/Helmet 2.png"),
    }

    local imageX = 0
    local imageY = 0
    local clickable = true

    local imageSx = love.graphics.getWidth() / images[1]:getWidth()
    local imageSy = love.graphics.getHeight() / images[1]:getHeight()

    local unscaledAssetX, unscaledAssetY, unscaledAssetWidth, unscaledAssetHeight = table.unpack({1669 - 2559, 74, 275, 291})
    local assetX = unscaledAssetX * imageSx
    local assetY = unscaledAssetY * imageSy
    local assetWidth = unscaledAssetWidth * imageSx
    local assetHeight = unscaledAssetHeight * imageSy

    local dialogueTree = DialogueTree(
        {
            [1] =

            {
                {"Daniel", "My helmet. Haven't worn it in a while."}
            },
 
            [2] =

            {
                {"Daniel", "In third grade, my class was told to write about who we wanted to be when we grew up.\n\nI wrote, \"Debris collector.\""},
                {"Daniel", "Unfortunately, my school bully saw."},
                {"Daniel", "He looked over my shoulder, saw what I wrote, pried the paper from my hands, and said:\n\n\"Look everybody! Beaner boy wants to be a space janitor!\""},
                {"Daniel", "I immediately flushed red from shame.\n\nWas that a silly child's idea, to want to make the universe a safer place to live?"},
                {"Daniel", "Even now, I still don't see what's so silly about it, but maybe that's because I'm just a child."}
            },

            [3] =
            
            {
                {"Daniel", "I had this helmet with me at the airport before I left."},
                {"Daniel", "Before I boarded, Nana squeezed me harder than she ever had before. She couldn't stop crying."},
                {"Daniel", "I let out a bittersweet laugh and asked her,\n\n\"You don't want me to go Nana?\""},
                {"Daniel", "She said,\n\n\"Of course I don't want you to go. But even more than that, I just want you to be happy.\""},
                {"Daniel", "I feel like I understand her pain a little more now."},
                {"Daniel", "Wasn't it hard Nana? Didn't you miss me? Didn't you feel lonely?"},
                {"Daniel", "Did you feel the emptiness of my absence when you walked into my empty bedroom? Did you feel the sadness of setting one less plate at the dinner table?"},
                {"Daniel", "I'm sorry Nana. I was always in your thoughts, wasn't I? I'm sorry you weren't always in mine."},
                {"Daniel", "When I'm out of here, I'll give you a call. I promise."}
            },

            [4] =

            {
                {"Daniel", "My helmet."},
            },

            [5] =

            {
                {"Daniel", "My helmet."},
            },
             
            [6] =

            {
                {"Daniel", "My helmet."},
            }
        }
    )

    Helmet.super.new(self, images, imageX, imageY, clickable, assetX, assetY, assetWidth, assetHeight, dialogueTree)
end