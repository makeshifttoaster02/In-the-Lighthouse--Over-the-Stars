Leaf = Item:extend()

function Leaf:new()
    local images = {
        love.graphics.newImage("Assets/Leaf 1.png"),
        love.graphics.newImage("Assets/Leaf 2.png"),
    }

    local imageX = 0
    local imageY = 0
    local clickable = true

    local imageSx = love.graphics.getWidth() / images[1]:getWidth()
    local imageSy = love.graphics.getHeight() / images[1]:getHeight()

    local unscaledAssetX, unscaledAssetY, unscaledAssetWidth, unscaledAssetHeight = table.unpack({2150 - 2559, 274, 121, 88})
    local assetX = unscaledAssetX * imageSx
    local assetY = unscaledAssetY * imageSy
    local assetWidth = unscaledAssetWidth * imageSx
    local assetHeight = unscaledAssetHeight * imageSy

    local dialogueTree = DialogueTree(
        {{"Daniel", "On the last day we all lived under one roof, we carved N-D-G on our old lime tree, daring tomorrow never to come."}}
    )

    Leaf.super.new(self, images, imageX, imageY, clickable, assetX, assetY, assetWidth, assetHeight, dialogueTree)
end