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

    self.fresh = true
    self.eternallyFresh = false
end

function Item:update(dt, cursorX, cursorY)

end

function Item:draw()
    local image = self:getCurrentImage()
    if not self.fresh or not self.clickable then
        love.graphics.setShader(Game:getGrayShader())
    end
    if self.hovering then
        love.graphics.setShader(Game:getWhiteShader())
        if not self.fresh then
            love.graphics.setShader(Game:getLightGrayShader())
        end
        love.graphics.draw(image, self.imageX, self.imageY, 0, self.imageSx, self.imageSy)
    else
        love.graphics.draw(image, self.imageX, self.imageY, 0, self.imageSx, self.imageSy)
    end
    love.graphics.setShader()
end

function Item:mousereleased(cursorX, cursorY)
    if self.clickable and self:withinBounds(cursorX, cursorY) then
        self.dialogueTree:initialize()
        self.hovering = false
        if not self.eternallyFresh then
            self.fresh = false
        end
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
    local assetCursorX = self.assetX - OffsetManager:getOffset()
    local assetCursorY = self.assetY
    return assetCursorX <= cursorX and cursorX <= assetCursorX + self.assetWidth
            and assetCursorY <= cursorY and cursorY <= assetCursorY + self.assetHeight
end

function Item:markHovering(cursorX, cursorY)
    if self.clickable and self:withinBounds(cursorX, cursorY) then
        self.hovering = true
        Game:setHovering()
    else
        self.hovering = false
    end
end

function Item:freshen()
    self.fresh = true
end

function Item:unfreshen()
    if not self.eternallyFresh then
        self.fresh = false
    end
end

function Item:isFresh()
    return self.fresh
end

function Item:getDialogueTree()
    return self.dialogueTree
end

function Item:setDialogueTree(dialogueTree)
    self.dialogueTree = dialogueTree
end

function Item:uneternallyFresh()
    self.eternallyFresh = false
end