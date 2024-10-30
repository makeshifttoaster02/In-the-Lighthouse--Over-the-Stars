Background = Object:extend()

function Background:load()
    self.drawables = {
        -- Computer(),
        Glove1(),
        Glove2(),
        Window(),
        Suit(),
        Door(),
        Bed(),
        Shelf(),
        Rocket(),
        Leaf(),
        Helmet()
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
    for _, currDrawable in pairs(self.drawables) do
        currDrawable:draw()
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