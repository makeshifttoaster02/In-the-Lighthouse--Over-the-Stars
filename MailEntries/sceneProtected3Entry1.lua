SceneProtected3Entry1 = MailEntry:extend()

function SceneProtected3Entry1:new()
    local title = "memory.png"
    local sender = nil
    local date = nil
    local index = 1
    SceneProtected3Entry1.super.new(self, title, sender, date, index)

    self.icon = love.graphics.newImage("Icons/Picture.png")
    self.width = Terminal:getWidth() - 4 * self.margin
    self.x = 2 * self.margin
    self.iconMargin = 3 * self.margin
end

function SceneProtected3Entry1:draw()
    local scrollOffset = Terminal:getHidable("SceneProtected3"):getScrollOffset()

    love.graphics.setLineWidth(4)
    love.graphics.rectangle("line", self.x, self.y - scrollOffset, self.width, self.height, self.radius)

    if self.hovering then
        love.graphics.rectangle("fill", self.x, self.y - scrollOffset, self.width, self.height, self.radius)
        local blackShader = Terminal:getInvertShader()
        love.graphics.setShader(blackShader)
    end

    local iconX = self.iconMargin * 1.5
    local iconY = self.y + self.height / 2 - self.titleFontSize / 2 - scrollOffset
    local iconSx = self.desiredIconLength / self.icon:getWidth()
    local iconSy = self.desiredIconLength / self.icon:getHeight()
    love.graphics.draw(self.icon, iconX, iconY, 0, iconSx, iconSy)

    local titleX = self.titleMargin + iconX
    local titleY = self.y + self.height / 2 - self.titleFontSize / 1.5 - scrollOffset
    love.graphics.print(self.title, self.titleFont, titleX, titleY)

    love.graphics.setShader()
end

function SceneProtected3Entry1:mousereleased(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        Terminal:hideAll()
        Terminal:getHidable("SceneProtected4"):show()
    end
end
