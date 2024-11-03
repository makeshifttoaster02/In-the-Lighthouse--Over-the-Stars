BackButton = Button:extend()

function BackButton:new(x, y, text, fontSize)
    BackButton.super.new(self, x, y, text, fontSize)

    self.day6dialogueDoorTriggered = false
    self.day6dialogueWindowTriggered = false
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
            Terminal:getHidable("SceneMail1"):resetScrollOffset()

            if not self.day6dialogueDoorTriggered then
                if Terminal:getHidable("SceneMail1Message7"):isSeen() then
                    Background:getDrawable("Door"):dialogueChangeMid6()
                    self.day6dialogueDoorTriggered = true
                end
            end

            if not self.day6dialogueWindowTriggered then
                if Terminal:getHidable("SceneProtected4"):isSeen() and Terminal:getHidable("SceneMail1Message7"):isSeen() then
                    Background:getDrawable("Window"):dialogueChangeMid6()
                    self.day6dialogueWindowTriggered = true
                end
            end
        end
    end
end

function BackButton:draw()
    if not Terminal:getHidable("Menu"):isVisible() then
        BackButton.super.draw(self)
    end
end

function BackButton:markHovering(cursorX, cursorY)
    if not Terminal:getHidable("Menu"):isVisible() then
        BackButton.super.markHovering(self, cursorX, cursorY)
    end
end