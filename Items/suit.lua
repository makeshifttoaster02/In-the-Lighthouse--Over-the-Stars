Suit = Item:extend()

function Suit:new()
    local images = {
        love.graphics.newImage("Assets/Suit 1.png"),
        love.graphics.newImage("Assets/Suit 2.png"),
    }

    local imageX = love.graphics.getWidth() * 2
    local imageY = 0
    local clickable = true

    local imageSx = love.graphics.getWidth() / images[1]:getWidth()
    local imageSy = love.graphics.getHeight() / images[1]:getHeight()

    local unscaledAssetX, unscaledAssetY, unscaledAssetWidth, unscaledAssetHeight = table.unpack({2559 + 72, 362, 521, 942})
    local assetX = unscaledAssetX * imageSx
    local assetY = unscaledAssetY * imageSy
    local assetWidth = unscaledAssetWidth * imageSx
    local assetHeight = unscaledAssetHeight * imageSy

    local dialogueTree = DialogueTree(
        {
            [1] =

            {
                {"Daniel", "My astronaut suit. It's a bit worn."}
            },

            [2] =

            {
                {"Daniel", "Nana didn't like astronauts when I was a kid."},
                {"Daniel", "She'd say,\n\n\"Why are we sending men to the moon when there are starving children in the ghettoes?\""},
                {"Daniel", "\"Why are there scientists doing rocket physics when there are no physicians near the slums?\""},
                {"Daniel", "\"I wish the people of this world would look at Earth, not at space.\""},
            },

            [3] =

            {
                {"Daniel", "When I told Nana I wanted to work in space, I asked her if she was disappointed."},
                {"Daniel", "She pointed up at the sky and said,\n\n\"Look at those starships, mijito. What do you think their purpose is?\""},
                {"Daniel", "\"To sail?\" I asked."},
                {"Daniel", "\"No,\" she said.\n\n\"Their purpose is to reach a port.\""},
                {"Daniel", "\"But in life, many people find themselves sailing without any idea of what port they're supposed to reach.\""},
                {"Daniel", "\"They live a life where living doesn't matter, only sailing does. And that's too sad.\""},
                {"Daniel", "\"I want you to live, mijito.\""},
                {"Daniel", "Nana didn't always understand me, but she never failed to accept me."},
            },

            [4] =

            {
                {"Daniel", "My astronaut suit."},
            },

            [5] =

            {
                {"Daniel", "It never really bothered me that Nana didn't understand my longing for space."},
                {"Daniel", "But that's because I used to wonder how anyone could ever understand another person."},
                {"Daniel", "All our language and perception is the sum of our prior dreams and experiences, right? What we see isn't what we see but what we are.\n\nSo my definition of \"hate\" and \"abuse\" is different from yours."},
                {"Daniel", "But then Nana goes and tells me that she loves me, and I know what she means, and I feel the same."},
            },

            [6] =

            {
                {"Daniel", "My astronaut suit."},
            },
        }
    )

    Suit.super.new(self, images, imageX, imageY, clickable, assetX, assetY, assetWidth, assetHeight, dialogueTree)
end