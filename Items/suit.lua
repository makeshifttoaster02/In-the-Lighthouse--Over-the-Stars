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
        {{"Daniel", "My astronaut suit. It's a bit worn."}}
    )

    Suit.super.new(self, images, imageX, imageY, clickable, assetX, assetY, assetWidth, assetHeight, dialogueTree)
end