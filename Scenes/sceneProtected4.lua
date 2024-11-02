SceneProtected4 = Hidable:extend()

function SceneProtected4:new()
    self.image = love.graphics.newImage("Assets/Memory.png")
    self.aspectRatio = self.image:getWidth() / self.image:getHeight()
    self.margin = Terminal:getHeight() / 8
    self.desiredImageHeight = Terminal:getHeight() - 2 * self.margin
    self.desiredImageWidth = self.desiredImageHeight * self.aspectRatio
    self.imageX = Terminal:getWidth() / 2 - self.desiredImageWidth / 2
    self.imageY = self.margin
end

function SceneProtected4:update(dt, cursorX, cursorY)
end

function SceneProtected4:draw()
    if self.visible then
        SetColorHEX("#090909")
        love.graphics.rectangle("fill", self.imageX, self.imageY, self.desiredImageWidth, self.desiredImageHeight)

        SetColorHEX("#FFFFFF")

        local imageSx = self.desiredImageWidth / self.image:getWidth()
        local imageSy = self.desiredImageHeight / self.image:getHeight()
        love.graphics.draw(self.image, self.imageX, self.imageY, 0, imageSx, imageSy)

        SetColorHEX("#FFFFFF")
        love.graphics.setLineWidth(7)
        love.graphics.rectangle("line", self.imageX, self.imageY, self.desiredImageWidth, self.desiredImageHeight)
        love.graphics.setLineWidth(3)
    end
end

function SceneProtected4:mousereleased(cursorX, cursorY)
end

function SceneProtected4:restoreDefaults()
end