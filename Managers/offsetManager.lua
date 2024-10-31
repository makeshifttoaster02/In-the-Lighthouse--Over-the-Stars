OffsetManager = Object:extend()

function OffsetManager:load()
    self.offset = 0
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