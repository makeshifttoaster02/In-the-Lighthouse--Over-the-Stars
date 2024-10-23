Taskbar = Object:extend()

function Taskbar:load()
    self.x = 0
    self.y = Terminal:getHeight()
    self.date = "November 13, 2083"

    self.buttonVerticalMargin = love.graphics.getHeight() / 40
    self.buttonHorizontalMargin = self.buttonVerticalMargin * 2
    self.buttonFontSize = love.graphics.getHeight() / 50
    self.button = BackButton(self.x, self.y + self.buttonVerticalMargin, "Back", self.buttonFontSize)
    self.button:setX(self.x + Terminal:getWidth() - self.button:getWidth() - self.buttonHorizontalMargin)

    self.dateFontSize = Terminal:getHeight() / 20
    self.dateFont = love.graphics.newFont("Fonts/Pinscher.otf", self.dateFontSize)
    self.dateMargin = love.graphics.getHeight() / 100
end

function Taskbar:update(dt, cursorX, cursorY)
    self.button:markHovering(cursorX, cursorY)
end

function Taskbar:draw()
    -- love.graphics.setLineWidth(3)
    -- love.graphics.rectangle("line", self.x, self.y, Terminal:getWidth(), self.button:getHeight() + 2 * self.buttonVerticalMargin)

    local dateWidth = self.dateFont:getWidth(self.date)
    local dateX = self.x + Terminal:getWidth() - self.button:getWidth() - dateWidth - self.dateMargin - self.buttonHorizontalMargin
    local dateY = self.y - self.dateFontSize + self.button:getHeight() - self.dateMargin + self.buttonVerticalMargin
    love.graphics.print(self.date, self.dateFont, dateX, dateY)
    self.button:draw()
end

function Taskbar:mousereleased(cursorX, cursorY)
    self.button:mousereleased(cursorX, cursorY)
end

function Taskbar:getHeight()
    return self.button:getHeight() + 2 * self.buttonVerticalMargin
end