BackButton = Button:extend()

function BackButton:new(x, y, text, fontSize)
    BackButton.super.new(self, x, y, text, fontSize)
end

function BackButton:mousereleased(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) then
        local currHidable = Terminal:getCurrHidable()
        if currHidable ~= nil and currHidable:isMailMessage() then
            Terminal:hideAll()
            Terminal:getHidable("SceneMail1"):show()
        else
            Terminal:hideAll()
            Terminal:getHidable("Menu"):show()
        end
    end
end

function BackButton:draw()
    if not Terminal:getHidable("Menu"):isVisible() then
        love.graphics.setLineWidth(3)
        love.graphics.rectangle("line", self.x, self.y, self.width, self.height, self.radius)

        if self.hovering then
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.radius)
            local blackShader = Terminal:getInvertShader()
            love.graphics.setShader(blackShader)
        end

        love.graphics.printf(self.text, self.font, self.x, self.y + self.margin, self.width, "center")
        love.graphics.setShader()
    end
end