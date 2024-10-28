Menu = Hidable:extend()

function Menu:new()
    self.options = {OptionProtected(), OptionMail(), OptionRadar(), OptionSos()}
    self:show()
end

function Menu:update(dt, cursorX, cursorY)
    if self.visible then
        for i = 1, #self.options do
            local currOption = self.options[i]
            currOption:markHovering(cursorX, cursorY)
        end
    end
end

function Menu:draw()
    if self.visible then
        for i = 1, #self.options do
            local currOption = self.options[i]
            currOption:draw()
        end
    end
end

function Menu:mousereleased(cursorX, cursorY)
    if self.visible then
        for i = 1, #self.options do
            local currOption = self.options[i]
            if currOption:withinBounds(cursorX, cursorY) then
                currOption:goToScene()
                break
            end
        end
    end
end