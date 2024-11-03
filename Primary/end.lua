End = Object:extend()

function End:load()
    self.opacity = 0
    self.fadingIn = false
    self.fadeSpeed = 0.2
    self.readyToEnd = false

    self.holdDuration = 3
    self.currDuration = 0
end

function End:update(dt)
    if self.fadingIn then
        self.opacity = math.min(self.opacity + self.fadeSpeed * dt, 1)
    end

    if self.opacity == 1 then
        self.currDuration = self.currDuration + dt
        if self.currDuration >= self.holdDuration then
            self.readyToEnd = true
        end
    end
end

function End:draw()
    love.graphics.setColor(1, 1, 1, self.opacity)
    if self.readyToEnd then
        love.graphics.setColor(0, 0, 0, 1)
    end
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    SetColorHEX("#FFFFFF")
end

function End:fadeIn()
    self.fadingIn = true
    Background:getDrawable("Door"):uneternallyFresh()
    Background:getDrawable("Door"):unfreshen()
end

function End:isFadingIn()
    return self.fadingIn
end

function End:isReadyToEnd()
    return self.readyToEnd
end