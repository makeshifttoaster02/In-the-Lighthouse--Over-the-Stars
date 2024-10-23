Screen = Object:extend()

function Screen:load()
    self.crtShader = love.graphics.newShader(love.filesystem.read("Shaders/CRT.glsl"))
    Terminal:load()
    Taskbar:load()
end

function Screen:update(dt, cursorX, cursorY)
    self.crtShader:send("elapsed", love.timer.getTime())
    Terminal:update(dt, cursorX, cursorY)
    Taskbar:update(dt, cursorX, cursorY)
end

function Screen:draw()
    SetColorHEX("#000000")
    love.graphics.rectangle("fill", 0, 0, love.graphics.getHeight(), love.graphics.getWidth())
    SetColorHEX("#FFFFFF")

    Terminal:draw()
    Taskbar:draw()
end

function Screen:mousereleased(cursorX, cursorY)
    Terminal:mousereleased(cursorX, cursorY)
    Taskbar:mousereleased(cursorX, cursorY)
end

function Screen:keypressed(key)
    Terminal:keypressed(key)
end

function Screen:wheelmoved(y)
    Terminal:wheelmoved(y)
end

function Screen:getHeight()
    return Terminal:getHeight() + Taskbar:getHeight()
end

function Screen:getWidth()
    return Terminal:getWidth()
end

function Screen:getCrtShader()
    return self.crtShader
end