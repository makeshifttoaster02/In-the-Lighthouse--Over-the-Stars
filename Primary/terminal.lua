Terminal = Object:extend()

function Terminal:load()
    self.terminalWidth = love.graphics.getWidth() * 3/5
    self.terminalHeight = love.graphics.getHeight() * 3/5
    self.terminalX = love.graphics.getWidth() / 2 - self.terminalWidth / 2
    self.terminalY = love.graphics.getHeight() / 2 - self.terminalHeight / 2

    self.invertShader = love.graphics.newShader(love.filesystem.read("Shaders/convertToBlack.glsl"))

    self.hidables = {}
    self.hidables["Menu"] = Menu()
    self.hidables["SceneSos1"] = SceneSos1()
    self.hidables["SceneSos2"] = SceneSos2()
    self.hidables["SceneSos3"] = SceneSos3()
    self.hidables["SceneProtected1"] = SceneProtected1()
    self.hidables["SceneProtected2"] = SceneProtected2()
    self.hidables["SceneProtected3"] = SceneProtected3()
    self.hidables["SceneProtected4"] = SceneProtected4()
    self.hidables["SceneMail1"] = SceneMail1()
    self.hidables["SceneMail1Message1"] = SceneMail1Message1()
    self.hidables["SceneMail1Message2"] = SceneMail1Message2()
    self.hidables["SceneMail1Message3"] = SceneMail1Message3()
    self.hidables["SceneMail1Message4"] = SceneMail1Message4()
    self.hidables["SceneMail1Message5"] = SceneMail1Message5()
    self.hidables["SceneMail1Message6"] = SceneMail1Message6()
    self.hidables["SceneMail1Message7"] = SceneMail1Message7()
    self.hidables["SceneRadar1"] = SceneRadar1()
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

    -- love.graphics.setShader(Terminal:getCrtShader())
    for _, currHidable in pairs(self.hidables) do
        if currHidable:isVisible() then
            currHidable:draw()
        end
    end
    -- love.graphics.setShader()
end

function Terminal:mousereleased(cursorX, cursorY)
    for _, currHidable in pairs(self.hidables) do
        if currHidable:isVisible() then
            currHidable:mousereleased(cursorX, cursorY)
            break
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

function Terminal:wheelmoved(y)
    for _, currHidable in pairs(self.hidables) do
        if currHidable:isVisible() then
            currHidable:wheelmoved(y)
        end
    end
end

function Terminal:textinput(t)
    for _, currHidable in pairs(self.hidables) do
        if currHidable:isVisible() then
            currHidable:textinput(t)
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

function Terminal:getHidable(name)
    return self.hidables[name]
end

function Terminal:getCurrHidable()
    for _, currHidable in pairs(self.hidables) do
        if currHidable:isVisible() then
            return currHidable
        end
    end

    return nil
end

function Terminal:getInvertShader()
    return self.invertShader
end

function Terminal:getCrtShader()
    return self.crtShader
end

function Terminal:isReplyInputActive()
    for _, currHidable in pairs(self.hidables) do
        if currHidable:isVisible() and currHidable:isMailMessage() and currHidable:isReplyInputActive() then
            return true
        end
    end

    return false
end