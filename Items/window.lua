Window = Item:extend()

function Window:new()
    local images = {
        love.graphics.newImage("Assets/Window 1.png"),
        love.graphics.newImage("Assets/Window 2.png"),
    }

    local imageX = love.graphics.getWidth()
    local imageY = 0
    local clickable = true

    local imageSx = love.graphics.getWidth() / images[1]:getWidth()
    local imageSy = love.graphics.getHeight() / images[1]:getHeight()

    local unscaledAssetX, unscaledAssetY, unscaledAssetWidth, unscaledAssetHeight = table.unpack({2134, 868, 378, 358})
    local assetX = unscaledAssetX * imageSx
    local assetY = unscaledAssetY * imageSy
    local assetWidth = unscaledAssetWidth * imageSx
    local assetHeight = unscaledAssetHeight * imageSy

    local dialogueTree = DialogueTree(
        {{"Daniel", "Outside the window, debris intermingles with the stars."}}
    )

    Window.super.new(self, images, imageX, imageY, clickable, assetX, assetY, assetWidth, assetHeight, dialogueTree)
end