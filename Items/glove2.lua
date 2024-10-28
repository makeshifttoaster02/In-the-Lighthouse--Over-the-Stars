Glove2 = Item:extend()

function Glove2:new()
    local images = {
        love.graphics.newImage("Assets/Glove 2 1.png"),
        love.graphics.newImage("Assets/Glove 2 2.png"),
    }

    local imageX = 0
    local imageY = 0
    local clickable = true

    local imageSx = love.graphics.getWidth() / images[1]:getWidth()
    local imageSy = love.graphics.getHeight() / images[1]:getHeight()

    local unscaledAssetX, unscaledAssetY, unscaledAssetWidth, unscaledAssetHeight = table.unpack({375, 340, 223, 422})
    local assetX = unscaledAssetX * imageSx
    local assetY = unscaledAssetY * imageSy
    local assetWidth = unscaledAssetWidth * imageSx
    local assetHeight = unscaledAssetHeight * imageSy

    local dialogueTree = DialogueTree(
        {{"Daniel", "The wrong glove for the left hand."}}
    )

    Glove2.super.new(self, images, imageX, imageY, clickable, assetX, assetY, assetWidth, assetHeight, dialogueTree)

    self.isClicked = true
end