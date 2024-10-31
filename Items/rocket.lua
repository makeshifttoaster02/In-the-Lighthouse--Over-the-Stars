Rocket = Item:extend()

function Rocket:new()
    local images = {
        love.graphics.newImage("Assets/Rocket 1.png"),
        love.graphics.newImage("Assets/Rocket 2.png"),
    }

    local imageX = 0
    local imageY = 0
    local clickable = true

    local imageSx = love.graphics.getWidth() / images[1]:getWidth()
    local imageSy = love.graphics.getHeight() / images[1]:getHeight()

    local unscaledAssetX, unscaledAssetY, unscaledAssetWidth, unscaledAssetHeight = table.unpack({2000 - 2559, 159, 145, 214})
    local assetX = unscaledAssetX * imageSx
    local assetY = unscaledAssetY * imageSy
    local assetWidth = unscaledAssetWidth * imageSx
    local assetHeight = unscaledAssetHeight * imageSy

    local dialogueTree = DialogueTree(
        {
            [1] =

            {
                {"Daniel", "My miniature rocket.\n\nGael made it for me before I left to space."}
            },

            [2] =

            {
                {"Daniel", "Gael and I lived with Nana, 120 miles away from the nearest city."},
                {"Daniel", "When we got home from school, the two of us would clamor out of the car and excitedly get to work on the telescope we were building."},
                {"Daniel", "When the telescope was done, we perched it underneath a moonkissed tree and spent hours stargazing."},
                {"Daniel", "Away from the city, away from the world, we watched the windblown clouds melt away into cotton candy swirls of pinks and purples."},
                {"Daniel", "We didn't know we were making memories - we were just having fun."}
            },

            [3] =

            {
                {"Daniel", "My miniature rocket.\n\nGael made it for me before I left to space."}
            },

            [4] =

            {
                {"Daniel", "My miniature rocket."}
            },

            [5] =

            {
                {"Daniel", "One time, I woke up at 6 AM to get some water and found Gael working on his solenoid engine."},
                {"Daniel", "I asked him, \"How in the universe are you so motivated to work on this?\" with a laugh."},
                {"Daniel", "He gave me a wry smile.\n\n\"I'm not a hard worker or anything, I just do it because I'm scared.\""},
                {"Daniel", "He told me his biggest fear was dying before he got to do all the things he wanted to do. That he would sleep during his youth, wake up as an old man, and then die."},
                {"Daniel", "I agreed with him at the time without thinking about it too much.\n\nBut now, all I can think is how reincarnation is so much scarier than death."},
                {"Daniel", "The idea that all of our history, all of our experiences, all the love we've ever felt are wiped away in our next life as if they were writing on a chalkboard - it's too sad to think about."},
                {"Daniel", "I don't want another life."},
                {"Daniel", "I hope the last time I close my eyes is what forever feels like."},
            },

            [6] =

            {
                {"Daniel", "My miniature rocket."}
            }
        }
    )

    Rocket.super.new(self, images, imageX, imageY, clickable, assetX, assetY, assetWidth, assetHeight, dialogueTree)
end