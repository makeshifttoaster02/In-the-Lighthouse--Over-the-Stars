Game = Object:extend()

function Game:load()
    love.keyboard.setKeyRepeat(true)

    math.randomseed(os.time())

    TEsound.volume("all", 0.05)
    TEsound.playLooping("Sounds/Ambient 1.mp3", "stream", "music")

    self.start = true
    self.debug = false

    self.offset = 0
    self.handCursor = love.mouse.getSystemCursor("hand")

    DayManager:load()

    Screen:load()
    self.screenCanvas = love.graphics.newCanvas(Screen:getWidth(), Screen:getHeight())
    self.backgroundCanvas = love.graphics.newCanvas(love.graphics.getWidth() * 3, love.graphics.getHeight())

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

    for _, card in ipairs(ChapterCards) do
        card:update(dt)
    end
    
    if self.hovering then
        love.mouse.setCursor(self.handCursor)
    else
        love.mouse.setCursor()
    end

    self:moveOffset(cursorX)

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

    for day, card in ipairs(ChapterCards) do
        if DayManager:getDay() == day then
            card:draw()
            break
        end
    end

    if self.debug then
        love.graphics.print(DayManager:getDay(), 0, 0)
    end
end

function Game:mousereleased(cursorX, cursorY, button)
    if not ChapterCards:hasActive() then
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
    if not ChapterCards:hasActive() then
        Screen:keypressed(key)
        if key == "left" then
            self:decrementOffset(love.graphics.getWidth() / 50)
            self.offset = math.max(self.offset - love.graphics.getWidth() / 50, - love.graphics.getWidth() / 2)
        elseif key == "right" then
            self:incrementOffset(love.graphics.getWidth() / 50)
            self.offset = math.min(self.offset + love.graphics.getWidth() / 50, love.graphics.getWidth() / 2)
        end

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

function Game:getGrayShader()
    return self.grayShader
end

function Game:getOffset()
    return self.offset
end

function Game:removeStart()
    self.start = false
end

function Game:setOffset(offset)
    self.offset = offset
end

function Game:moveOffset(cursorX)
    if cursorX <= love.graphics.getWidth() / 30 then
        self:decrementOffset(love.graphics.getWidth() / 100)
    elseif cursorX >= love.graphics.getWidth() * (1 - 1 / 30) then
        self:incrementOffset(love.graphics.getWidth() / 100)
    end
end

function Game:decrementOffset(decrease)
    self.offset = math.max(self.offset - decrease, - love.graphics.getWidth() / 2)
end

function Game:incrementOffset(increase)
    self.offset = math.min(self.offset + increase, love.graphics.getWidth() / 2)
end