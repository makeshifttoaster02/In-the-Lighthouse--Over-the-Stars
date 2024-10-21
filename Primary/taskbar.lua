Taskbar = Object:extend()

function Taskbar:load()
    self.x = Terminal:getX()
    self.y = Terminal:getHeight() + Terminal:getY()
    self.date = "05/18/2083"

    self.buttonMargin = love.graphics.getHeight() / 100
    self.buttonFontSize = love.graphics.getHeight() / 50
    self.button = BackButton(self.x, self.y + self.buttonMargin, "Back", self.buttonFontSize)
    self.button:setX(self.x + Terminal:getWidth() - self.button:getWidth() - self.buttonMargin)

    self.dateFontSize = Terminal:getHeight() / 20
    self.dateFont = love.graphics.newFont("Fonts/Pinscher.otf", self.dateFontSize)
    self.dateMargin = love.graphics.getHeight() / 100
end

function Taskbar:update(dt, cursorX, cursorY)
    self.button:markHovering(cursorX, cursorY)
end

function Taskbar:draw()
    local dateWidth = self.dateFont:getWidth(self.date)
    local dateX = self.x + Terminal:getWidth() - self.button:getWidth() - dateWidth - self.dateMargin - self.buttonMargin
    local dateY = self.y - self.dateFontSize + self.button:getHeight() - self.dateMargin + self.buttonMargin
    love.graphics.print(self.date, self.dateFont, dateX, dateY)
    self.button:draw()
end

function Taskbar:mousereleased(cursorX, cursorY)
    self.button:mousereleased(cursorX, cursorY)
end