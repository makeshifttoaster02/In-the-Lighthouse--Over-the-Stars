Glove1 = Item:extend()

function Glove1:new()
    local images = {
        love.graphics.newImage("Assets/Glove 1 1.png"),
        love.graphics.newImage("Assets/Glove 1 2.png"),
    }

    local imageX = love.graphics.getWidth()
    local imageY = 0
    local clickable = true

    local imageSx = love.graphics.getWidth() / images[1]:getWidth()
    local imageSy = love.graphics.getHeight() / images[1]:getHeight()

    local unscaledAssetX, unscaledAssetY, unscaledAssetWidth, unscaledAssetHeight = table.unpack({2132, 140, 165, 365})
    local assetX = unscaledAssetX * imageSx
    local assetY = unscaledAssetY * imageSy
    local assetWidth = unscaledAssetWidth * imageSx
    local assetHeight = unscaledAssetHeight * imageSy

    local dialogueTree = DialogueTree(
        {
            [1] =

            {
                {"Daniel", "The right glove for the right hand."}
            },

            [2] =

            {
                {"Daniel", "The right glove for the right hand."}
            },

            [3] =

            {
                {"Daniel", "The right glove for the right hand."}
            },

            [4] =

            {
                {"Daniel", "The right glove for the right hand."}
            },

            [5] =

            {
                {"Daniel", "The right glove for the right hand."}
            },

            [6] =

            {
                {"Daniel", "The right glove for the right hand."}
            },
        }
    )

    Glove1.super.new(self, images, imageX, imageY, clickable, assetX, assetY, assetWidth, assetHeight, dialogueTree)
end