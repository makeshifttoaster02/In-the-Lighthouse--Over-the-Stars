Game = Object:extend()

function Game:load()
    love.keyboard.setKeyRepeat(true)

    math.randomseed(os.time())

    self.start = true
    self.debug = true

    self.handCursor = love.mouse.getSystemCursor("hand")

    OffsetManager:load()
    DayManager:load()
    CardManager:load()
    SongManager:load()

    Screen:load()
    self.screenCanvas = love.graphics.newCanvas(Screen:getWidth(), Screen:getHeight())
    self.backgroundCanvas = love.graphics.newCanvas(love.graphics.getWidth() * 3, love.graphics.getHeight())

    self.redShader = love.graphics.newShader(love.filesystem.read("Shaders/convertToRed.glsl"))
    self.yellowShader = love.graphics.newShader(love.filesystem.read("Shaders/convertToYellow.glsl"))
    self.lightGrayShader = love.graphics.newShader(love.filesystem.read("Shaders/convertToLightGray.glsl"))
    self.grayShader = love.graphics.newShader(love.filesystem.read("Shaders/convertToGray.glsl"))
    self.whiteShader = love.graphics.newShader(love.filesystem.read("Shaders/convertToWhite.glsl"))
    Background:load()

    DialogueBox:load()

    DayManager:setDay(1)
end

function Game:update(dt)
    TEsound.cleanup()

    local cursorX, cursorY = love.mouse.getPosition()
    Background:update(dt, cursorX, cursorY)
    Screen:update(dt, cursorX, cursorY)
    DialogueBox:update(dt, cursorX, cursorY)
    DialogueBox:markHovering(cursorX, cursorY)

    DayManager:update(dt)
    OffsetManager:update(dt, cursorX, cursorY)
    CardManager:update(dt)
    SongManager:update(dt)

    if self.hovering then
        love.mouse.setCursor(self.handCursor)
    else
        love.mouse.setCursor()
    end

    self.hovering = false
end

function Game:draw()
    self:drawBackground()
    self:drawScreen()
    DialogueBox:draw()

    if self.start then
        SetColorHEX("#000000")
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        SetColorHEX("#FFFFFF")
    end

    CardManager:draw()

    if self.debug then
        love.graphics.print(DayManager:getDay(), 0, 0)
    end
end

function Game:mousereleased(cursorX, cursorY, button)
    if not CardManager:hasSemiActive() then
        local leftMouseClick = 1
        if button == leftMouseClick then
            if DialogueBox:isVisible() then
                DialogueBox:mousereleased(cursorX, cursorY)
            else
                Background:mousereleased(cursorX, cursorY)
                Screen:mousereleased(cursorX, cursorY)
            end
        end
    end
end

function Game:keypressed(key)
    if not CardManager:hasSemiActive() then
        Screen:keypressed(key)
        OffsetManager:keypressed(key)

        if self.debug then
            if key >= "1" and key <= "6" then
                DayManager:setDay(tonumber(key))
            end
        end
    end
end

function Game:wheelmoved(y)
    Screen:wheelmoved(y)
end

function Game:textinput(t)
    Screen:textinput(t)
end

function Game:setHovering()
    self.hovering = true
end

function Game:drawScreen()
    love.graphics.setCanvas(self.screenCanvas)
    love.graphics.clear()

    Screen:draw()

    love.graphics.setCanvas()

    love.graphics.setShader(Screen:getCrtShader())
    love.graphics.draw(self.screenCanvas, Terminal:getX() - OffsetManager:getOffset(), Terminal:getY(), 0, 1, 1)

    love.graphics.setShader()
end

function Game:drawBackground()
    love.graphics.setCanvas(self.backgroundCanvas)
    love.graphics.clear()

    Background:draw()

    love.graphics.setCanvas()
    love.graphics.draw(self.backgroundCanvas, - love.graphics.getWidth() - OffsetManager:getOffset(), 0, 0, 1, 1)
end

function Game:getRedShader()
    return self.redShader
end

function Game:getYellowShader()
    return self.yellowShader
end

function Game:getWhiteShader()
    return self.whiteShader
end

function Game:getLightGrayShader()
    return self.lightGrayShader
end

function Game:getGrayShader()
    return self.grayShader
end

function Game:removeStart()
    self.start = false
end