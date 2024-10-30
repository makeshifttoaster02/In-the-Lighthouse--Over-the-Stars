Game = Object:extend()

function Game:load()
    love.keyboard.setKeyRepeat(true)

    math.randomseed(os.time())

    TEsound.volume("all", 0.05)
    TEsound.playLooping("Sounds/Ambient 1.mp3", "stream")

    self.offset = 0
    self.handCursor = love.mouse.getSystemCursor("hand")

    Screen:load()
    self.screenCanvas = love.graphics.newCanvas(Screen:getWidth(), Screen:getHeight())
    self.backgroundCanvas = love.graphics.newCanvas(love.graphics.getWidth() * 3, love.graphics.getHeight())

    self.whiteShader = love.graphics.newShader(love.filesystem.read("Shaders/convertToWhite.glsl"))
    Background:load()

    DialogueBox:load()
end

function Game:update(dt)
    TEsound.cleanup()

    local cursorX, cursorY = love.mouse.getPosition()
    Background:update(dt, cursorX, cursorY)
    Screen:update(dt, cursorX, cursorY)
    DialogueBox:update(dt, cursorX, cursorY)
    DialogueBox:markHovering(cursorX, cursorY)
    
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
end

function Game:mousereleased(cursorX, cursorY, button)
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

function Game:keypressed(key)
    Screen:keypressed(key)
    if key == "left" then
        self.offset = math.max(self.offset - love.graphics.getWidth() / 50, - love.graphics.getWidth() / 2)
    elseif key == "right" then
        self.offset = math.min(self.offset + love.graphics.getWidth() / 50, love.graphics.getWidth() / 2)
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
    love.graphics.draw(self.screenCanvas, Terminal:getX() - self.offset, Terminal:getY(), 0, 1, 1)

    love.graphics.setShader()
end

function Game:drawBackground()
    love.graphics.setCanvas(self.backgroundCanvas)
    love.graphics.clear()

    Background:draw()

    love.graphics.setCanvas()
    love.graphics.draw(self.backgroundCanvas, - love.graphics.getWidth() - self.offset, 0, 0, 1, 1)
end

function Game:getWhiteShader()
    return self.whiteShader
end

function Game:getOffset()
    return self.offset
end