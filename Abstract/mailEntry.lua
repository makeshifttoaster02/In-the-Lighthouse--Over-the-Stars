MailEntry = Object:extend()

function MailEntry:new(title, sender, date, index)
    self.title = title
    self.sender = sender
    self.date = date
    self.index = index

    self.titleFontSize = Terminal:getHeight() / 10
    self.otherFontSize = Terminal:getHeight() / 20

    self.titleFont = love.graphics.newFont("Fonts/Pinscher.otf", self.titleFontSize)
    self.otherFont = love.graphics.newFont("Fonts/Pinscher.otf", self.otherFontSize)

    self.width = Terminal:getWidth()
    self.height = Terminal:getHeight() / 5
end

function MailEntry:update(dt, cursorX, cursorY)

end

function MailEntry:draw()
    local titleX = Terminal:getWidth() / 20
    local titleY = Terminal:getHeight() / 20
    love.graphics.print(self.title, self.titleFont, titleX, titleY)
end