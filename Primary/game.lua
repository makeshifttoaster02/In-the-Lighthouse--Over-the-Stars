Game = Object:extend()

function Game:load()
    math.randomseed(os.time())
    TEsound.volume("all", 0.05)
    TEsound.playLooping("Sounds/Ambient 1.mp3", "stream")
    Screen:load()
end

function Game:update(dt)
    TEsound.cleanup()

    local cursorX, cursorY = love.mouse.getPosition()
    Screen:update(dt, cursorX, cursorY)
end

function Game:draw()
    Screen:draw()
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