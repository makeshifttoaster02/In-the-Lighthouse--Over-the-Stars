SceneProtected2 = Hidable:extend()

function SceneProtected2:new()
    self.icon = love.graphics.newImage("Icons/Incorrect.png")
    self.desiredIconLength = love.graphics.getHeight() / 4

    self.x = Terminal:getX()
    self.y = Terminal:getY()
    self.xIconMargin = Terminal:getWidth() / 2 - self.desiredIconLength / 2
    self.yIconMargin = Terminal:getHeight() / 2 - self.desiredIconLength / 2

    self.showUpdateDuration = 2
    self.showCurrDuration = 0
end

function SceneProtected2:update(dt, cursorX, cursorY)
    if self.visible then
        self.showCurrDuration = self.showCurrDuration + dt
        if self.showCurrDuration >= self.showUpdateDuration then
            self.showCurrDuration = 0
            Terminal:hideAll()
            Terminal:getHidables()["SceneProtected1"]:show()
        end
    end
end

function SceneProtected2:draw()
    if self.visible then
        local iconSx = self.desiredIconLength / self.icon:getWidth()
        local iconSy = self.desiredIconLength / self.icon:getHeight()

        local iconX = self.x + self.xIconMargin
        local iconY = self.y + self.yIconMargin
        love.graphics.draw(self.icon, iconX, iconY, 0, iconSx, iconSy)
    end
end

function SceneProtected2:mousereleased(cursorX, cursorY)
end

function SceneProtected2:restoreDefaults()
    self.showCurrDuration = 0
end