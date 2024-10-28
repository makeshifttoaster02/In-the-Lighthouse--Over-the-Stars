Game = Object:extend()

function Game:load()
    love.keyboard.setKeyRepeat(true)

    math.randomseed(os.time())

    TEsound.volume("all", 0.05)
    TEsound.playLooping("Sounds/Ambient 1.mp3", "stream")

    self.handCursor = love.mouse.getSystemCursor("hand")

    Screen:load()
    self.screenCanvas = love.graphics.newCanvas(Screen:getWidth(), Screen:getHeight())

    Background:load()

    DialogueBox:load()
end

function Game:update(dt)
    TEsound.cleanup()

    local cursorX, cursorY = love.mouse.getPosition()
    Background:update(dt, cursorX, cursorY)
    Screen:update(dt, cursorX, cursorY)
    DialogueBox:markHovering(cursorX, cursorY)
end

function Game:draw()
    Background:draw()
    self:drawScreen()
    DialogueBox:draw()
end

function Game:mousereleased(cursorX, cursorY, button)
    local leftMouseClick = 1
    if button == leftMouseClick then
        DialogueBox:mousereleased(cursorX, cursorY)
        Background:mousereleased(cursorX, cursorY)
        Screen:mousereleased(cursorX, cursorY)
    end
end

function Game:keypressed(key)
    Screen:keypressed(key)
end

function Game:wheelmoved(y)
    Screen:wheelmoved(y)
end

function Game:textinput(t)
    Screen:textinput(t)
end

function Game:setHandCursor()
    love.mouse.setCursor(self.handCursor)
end

function Game:setDefaultCursor()
    love.mouse.setCursor()
end

function Game:drawScreen()
    love.graphics.setCanvas(self.screenCanvas)
    love.graphics.clear()

    Screen:draw()

    love.graphics.setCanvas()

    love.graphics.setShader(Screen:getCrtShader())
    love.graphics.draw(self.screenCanvas, Terminal:getX(), Terminal:getY(), 0, 1, 1)

    love.graphics.setShader()
end