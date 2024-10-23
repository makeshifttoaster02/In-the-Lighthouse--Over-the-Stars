Game = Object:extend()

function Game:load()
    math.randomseed(os.time())
    TEsound.volume("all", 0.00)
    TEsound.playLooping("Sounds/Ambient 1.mp3", "stream")

    Screen:load()
    self.screenCanvas = love.graphics.newCanvas(Screen:getWidth(), Screen:getHeight())
end

function Game:update(dt)
    TEsound.cleanup()

    local cursorX, cursorY = love.mouse.getPosition()
    Screen:update(dt, cursorX, cursorY)
end

function Game:draw()
    self:drawScreen()
end

function Game:mousereleased(cursorX, cursorY, button)
    local leftMouseClick = 1
    if button == leftMouseClick then
        Screen:mousereleased(cursorX, cursorY)
    end
end

function Game:keypressed(key)
    Screen:keypressed(key)
end

function Game:wheelmoved(y)
    Screen:wheelmoved(y)
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