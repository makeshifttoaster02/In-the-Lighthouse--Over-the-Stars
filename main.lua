require("helpers")
require("tesound")
Object = require("classic")
require("Primary.terminal")
require("Abstract.hidable")
require("Primary.menu")
RequireDirectory("Primary")
RequireDirectory("Abstract")
RequireDirectory("Options")
RequireDirectory("Scenes")
RequireDirectory("Buttons")
RequireDirectory("MailEntries")
RequireDirectory("Messages")

function love.load()
    Game:load()
end

function love.update(dt)
    Game:update(dt)
end

function love.draw()
    Game:draw()
end

function love.mousereleased(cursorX, cursorY, button, istouch, presses)
    Game:mousereleased(cursorX, cursorY, button)
end

function love.keypressed(key, scancode, isrepeat)
    Game:keypressed(key)
end

function love.wheelmoved(x, y)
    Game:wheelmoved(y)
end