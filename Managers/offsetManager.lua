OffsetManager = Object:extend()

function OffsetManager:load()
    self.offset = 0
    self.leftArrow = love.graphics.newImage("Icons/LeftArrow.png")
    self.rightArrow = love.graphics.newImage("Icons/RightArrow.png")
    self.desiredIconLength = love.graphics.getWidth() / 30
end

function OffsetManager:update(dt, cursorX, cursorY)
    if cursorX <= love.graphics.getWidth() / 100 then
        self:decrementOffset(love.graphics.getWidth() / 100)
    elseif cursorX <= love.graphics.getWidth() / 30 then
        self:decrementOffset(love.graphics.getWidth() / 200)
    elseif cursorX >= love.graphics.getWidth() * (1 - 1 / 100) then
        self:incrementOffset(love.graphics.getWidth() / 100)
    elseif cursorX >= love.graphics.getWidth() * (1 - 1 / 30) then
        self:incrementOffset(love.graphics.getWidth() / 200)
    end
end

function OffsetManager:draw()
    local iconSx = self.desiredIconLength / self.leftArrow:getWidth()
    local iconSy = self.desiredIconLength / self.leftArrow:getHeight()
    if self.offset ~= - love.graphics.getWidth() / 2 then
        love.graphics.draw(self.leftArrow, 0, love.graphics.getHeight() / 2 - self.desiredIconLength / 2, 0, iconSx, iconSy)
    end
    if self.offset ~= love.graphics.getWidth() / 2 then
        love.graphics.draw(self.rightArrow, love.graphics.getWidth() - self.desiredIconLength, love.graphics.getHeight() / 2 - self.desiredIconLength / 2, 0, iconSx, iconSy)
    end
end

function OffsetManager:keypressed(key)
    local inputActive = false
    local mailMessageNames = {"SceneMail1Message1", "SceneMail1Message2", "SceneMail1Message3", "SceneMail1Message4", "SceneMail1Message5"}
    for _, name in ipairs(mailMessageNames) do
        inputActive = inputActive or Terminal:getHidable(name):isReplyInputActive()
    end
    if not inputActive then
        if key == "left" then
            self:decrementOffset(love.graphics.getWidth() / 50)
        elseif key == "right" then
            self:incrementOffset(love.graphics.getWidth() / 50)
        end
    end
end

function OffsetManager:decrementOffset(decrease)
    self.offset = math.max(self.offset - decrease, - love.graphics.getWidth() / 2)
end

function OffsetManager:incrementOffset(increase)
    self.offset = math.min(self.offset + increase, love.graphics.getWidth() / 2)
end

function OffsetManager:getOffset()
    return self.offset
end

function OffsetManager:setOffset(offset)
    self.offset = offset
end