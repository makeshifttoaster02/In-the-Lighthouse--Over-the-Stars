Shelf = Item:extend()

function Shelf:new()
    local images = {
        love.graphics.newImage("Assets/Shelf 1.png"),
        love.graphics.newImage("Assets/Shelf 2.png"),
    }

    local imageX = 0
    local imageY = 0
    local clickable = false

    local imageSx = love.graphics.getWidth() / images[1]:getWidth()
    local imageSy = love.graphics.getHeight() / images[1]:getHeight()

    local unscaledAssetX, unscaledAssetY, unscaledAssetWidth, unscaledAssetHeight = table.unpack({1540 - 2559, 371, 808, 135})
    local assetX = unscaledAssetX * imageSx
    local assetY = unscaledAssetY * imageSy
    local assetWidth = unscaledAssetWidth * imageSx
    local assetHeight = unscaledAssetHeight * imageSy

    local dialogueTree = DialogueTree(
        {{"Daniel", ""}}
    )

    Shelf.super.new(self, images, imageX, imageY, clickable, assetX, assetY, assetWidth, assetHeight, dialogueTree)
end