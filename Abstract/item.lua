Item = Object:extend()

function Item:new(images, imageX, imageY, clickable, assetX, assetY, assetWidth, assetHeight, dialogueTree)
    self.images = images
    self.imageX = imageX
    self.imageY = imageY
    self.clickable = clickable

    self.imageSx = love.graphics.getWidth() / self.images[1]:getWidth()
    self.imageSy = love.graphics.getHeight() / self.images[1]:getHeight()

    self.assetX = assetX
    self.assetY = assetY
    self.assetWidth = assetWidth
    self.assetHeight = assetHeight

    self.dialogueTree = dialogueTree
end

function Item:update(dt, cursorX, cursorY)

end

function Item:draw()
    local image = self:getCurrentImage()
    love.graphics.draw(image, self.imageX, self.imageY, 0, self.imageSx, self.imageSy)
end

function Item:mousereleased(cursorX, cursorY)
    if self.clickable and self:withinBounds(cursorX, cursorY) then
        self.dialogueTree:trigger()
    end
end

function Item:getCurrentImage()
    local animationIndex = Background:getAnimationIndex() % #self.images
    if animationIndex == 0 then
        animationIndex = #self.images
    end
    return self.images[animationIndex]
end

function Item:withinBounds(cursorX, cursorY)
    return self.assetX <= cursorX and cursorX <= self.assetX + self.assetWidth
            and self.assetY <= cursorY and cursorY <= self.assetY + self.assetHeight
end