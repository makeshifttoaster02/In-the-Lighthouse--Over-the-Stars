Terminal = Object:extend()

function Terminal:load()
    self.terminalWidth = love.graphics.getWidth() / 2
    self.terminalHeight = love.graphics.getHeight() / 2
    self.terminalX = love.graphics.getWidth() / 2 - self.terminalWidth / 2
    self.terminalY = love.graphics.getHeight() / 2 - self.terminalHeight / 3 * 2

    self.hidables = {}
    self.hidables["Menu"] = Menu()
    self.hidables["SceneSos1"] = SceneSos1()
    self.hidables["SceneSos2"] = SceneSos2()
    self.hidables["SceneSos3"] = SceneSos3()
    self.hidables["SceneProtected1"] = SceneProtected1()
    self.hidables["SceneProtected2"] = SceneProtected2()
end

function Terminal:update(dt, cursorX, cursorY)
    for _, currHidable in pairs(self.hidables) do
        if currHidable:isVisible() then
            currHidable:update(dt, cursorX, cursorY)
        end
    end
end

function Terminal:draw()
    -- love.graphics.setLineWidth(3)
    -- love.graphics.rectangle("line", self.terminalX, self.terminalY, self.terminalWidth, self.terminalHeight)

    for _, currHidable in pairs(self.hidables) do
        if currHidable:isVisible() then
            currHidable:draw()
        end
    end
end

function Terminal:mousereleased(cursorX, cursorY)
    for _, currHidable in pairs(self.hidables) do
        if currHidable:isVisible() then
            currHidable:mousereleased(cursorX, cursorY)
        end
    end
end

function Terminal:keypressed(key)
    for _, currHidable in pairs(self.hidables) do
        if currHidable:isVisible() then
            currHidable:keypressed(key)
        end
    end
end

function Terminal:hideAll()
    for _, currHidable in pairs(self.hidables) do
        currHidable:hide()
    end
end

function Terminal:getX()
    return self.terminalX
end

function Terminal:getY()
    return self.terminalY
end

function Terminal:getWidth()
    return self.terminalWidth
end

function Terminal:getHeight()
    return self.terminalHeight
end

function Terminal:getHidables()
    return self.hidables
end