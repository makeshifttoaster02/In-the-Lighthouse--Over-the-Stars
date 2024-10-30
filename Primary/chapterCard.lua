ChapterCard = Object:extend()

function ChapterCard:new(number, title)
    self.number = number
    self.title = title
    self.opacity = 0
    self.fadeSpeed = 2
    self.fadingIn = false

    self.numberFontSize = love.graphics.getHeight() / 20
    self.titleFontSize = love.graphics.getHeight() / 10

    self.chapterFont = love.graphics.newFont("Fonts/Sunday Work.otf", self.numberFontSize)
    self.chapterText = "Chapter " .. self.number

    self.titleFont = love.graphics.newFont("Fonts/Sunday Work.otf", self.titleFontSize)
end

function ChapterCard:update(dt)
    if self.fadingIn then
        self.opacity = math.min(self.opacity + self.fadeSpeed * dt, 1)
    else
        self.opacity = math.max(self.opacity - self.fadeSpeed * dt, 0)
    end
end

function ChapterCard:draw()
    love.graphics.setColor(0, 0, 0, self.opacity)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(.8, .8, .8, self.opacity)
    love.graphics.printf(self.chapterText, self.chapterFont, 0, love.graphics.getHeight() * 1.5/5, love.graphics.getWidth(), "center")
    love.graphics.printf(self.title, self.titleFont, 0, love.graphics.getHeight() * 2/5, love.graphics.getWidth(), "center")
    SetColorHEX("#FFFFFF")
end

function ChapterCard:setFadingIn()
    self.fadingIn = true
end

function ChapterCard:setFadingOut()
    self.fadingIn = false
end

function ChapterCard:isFadingIn()
    return self.fadingIn
end