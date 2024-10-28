Computer = Item:extend()

function Computer:new()
    local images = {
        love.graphics.newImage("Assets/D Computer 1.png"),
        love.graphics.newImage("Assets/D Computer 2.png"),
    }
    local imageX = 0
    local imageY = 0
    local clickable = false

    local imageSx = love.graphics.getWidth() / images[1]:getWidth()
    local imageSy = love.graphics.getHeight() / images[1]:getHeight()

    local unscaledAssetX, unscaledAssetY, unscaledAssetWidth, unscaledAssetHeight = table.unpack({668, 72, 1247, 856})
    local assetX = unscaledAssetX * imageSx
    local assetY = unscaledAssetY * imageSy
    local assetWidth = unscaledAssetWidth * imageSx
    local assetHeight = unscaledAssetHeight * imageSy

    Computer.super.new(self, images, imageX, imageY, clickable, assetX, assetY, assetWidth, assetHeight)
end