Background = Object:extend()

function Background:load()
    self.drawables = {
        -- Computer(),
        ["Glove1"] = Glove1(),
        ["Glove2"] = Glove2(),
        ["Window"] = Window(),
        ["Suit"] = Suit(),
        ["Door"] = Door(),
        ["Bed"] = Bed(),
        ["Shelf"] = Shelf(),
        ["Rocket"] = Rocket(),
        ["Leaf"] = Leaf(),
        ["Helmet"] = Helmet()
    }

    self.animationIndex = 1
    self.animationDuration = 1
    self.currAnimationDuration = 0
end

function Background:update(dt, cursorX, cursorY)
    self.currAnimationDuration = self.currAnimationDuration + dt
    if self.currAnimationDuration >= self.animationDuration then
        self.currAnimationDuration = 0
        self.animationIndex = self.animationIndex + 1
    end

    for _, currDrawable in pairs(self.drawables) do
        if not DialogueBox:isVisible() then
            currDrawable:markHovering(cursorX, cursorY)
        end
    end
end

function Background:draw()
    self.drawables["Shelf"]:draw()
    for currDrawableName, currDrawable in pairs(self.drawables) do
        if currDrawableName ~= "Shelf" then
            currDrawable:draw()
        end
    end
end

function Background:mousereleased(cursorX, cursorY)
    for _, currDrawable in pairs(self.drawables) do
        currDrawable:mousereleased(cursorX, cursorY)
    end
end

function Background:getAnimationIndex()
    return self.animationIndex
end

function Background:freshenDrawables(toFreshen)
    for _, drawableName in ipairs(toFreshen) do
        self.drawables[drawableName]:freshen()
    end
end

function Background:unfreshenAll()
    for _, currDrawable in pairs(self.drawables) do
        currDrawable:unfreshen()
    end
end

function Background:getDrawable(drawableName)
    return self.drawables[drawableName]
end