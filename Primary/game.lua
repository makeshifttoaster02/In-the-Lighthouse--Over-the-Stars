Game = Object:extend()

function Game:load()
    math.randomseed(os.time())
    TEsound.volume("all", 0.05)
    TEsound.playLooping("Sounds/Ambient 1.mp3", "stream")

    self.background = love.graphics.newImage("Assets/Background 1.png")
    Terminal:load()
    Taskbar:load()
end

function Game:update(dt)
    TEsound.cleanup()

    local cursorX, cursorY = love.mouse.getPosition()
    Terminal:update(dt, cursorX, cursorY)
    Taskbar:update(dt, cursorX, cursorY)
end

function Game:draw()
    local bgSx = love.graphics.getWidth() / self.background:getWidth()
    local bgSy = love.graphics.getHeight() / self.background:getHeight()
    love.graphics.draw(self.background, 0, 0, 0, bgSx, bgSy)
    Terminal:draw()
    Taskbar:draw()
end

function Game:mousereleased(cursorX, cursorY, button)
    local leftMouseClick = 1
    if button == leftMouseClick then
        Terminal:mousereleased(cursorX, cursorY)
        Taskbar:mousereleased(cursorX, cursorY)
    end
end

function Game:keypressed(key)
    Terminal:keypressed(key)
end