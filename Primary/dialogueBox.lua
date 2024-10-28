DialogueBox = Object:extend()

function DialogueBox:load()
    self.currSpeaker = ""
    self.currDialogue = ""
    self.currDialogueTree = nil
    self.visible = false

    self.outerBoxXMargin = love.graphics.getWidth() / 5
    self.outerBoxYMargin = love.graphics.getHeight() / 20
    self.boxHeight = love.graphics.getHeight() / 4
    self.boxWidth = love.graphics.getWidth() - 2 * self.outerBoxXMargin

    self.innerBoxXMargin = love.graphics.getWidth() / 50
    self.innerBoxYMargin = love.graphics.getWidth() / 50
    self.boxX = self.outerBoxXMargin
    self.boxY = love.graphics.getHeight() - self.outerBoxYMargin - self.boxHeight
    self.boxFontSize = self.boxHeight / 10
    self.boxFont = love.graphics.newFont("Fonts/Pinscher.otf", self.boxFontSize)
    self.boxRadius = 10
end

function DialogueBox:draw()
    if self.visible then
        love.graphics.setLineWidth(3)
        love.graphics.rectangle("line", self.boxX, self.boxY, self.boxWidth, self.boxHeight, self.boxRadius)

        if self.hovering then
            love.graphics.rectangle("fill", self.boxX, self.boxY, self.boxWidth, self.boxHeight, self.boxRadius)
            local blackShader = Terminal:getInvertShader()
            love.graphics.setShader(blackShader)
        end

        local dialogueX = self.boxX + self.innerBoxXMargin
        local dialogueY = self.boxY + self.innerBoxYMargin
        local dialogueWidth = self.boxWidth - 2 * self.innerBoxXMargin
        love.graphics.printf(self.currDialogue, self.boxFont, dialogueX, dialogueY, dialogueWidth, "left")

        love.graphics.setShader()
    end
end

function DialogueBox:mousereleased(cursorX, cursorY)
    if self.visible and self:withinBounds(cursorX, cursorY) then
        self.currDialogueTree:trigger()
    end
end

function DialogueBox:markHovering(cursorX, cursorY)
    if self.visible then
        if self:withinBounds(cursorX, cursorY) then
            if not self.hovering then
                TEsound.play("Sounds/Hover.wav", "static")
            end
            self.hovering = true
            Game:setHovering()
        else
            self.hovering = false
        end
    end
end

function DialogueBox:withinBounds(cursorX, cursorY)
    return self.boxX <= cursorX and cursorX <= self.boxX + self.boxWidth and
            self.boxY <= cursorY and cursorY <= self.boxY + self.boxHeight
end

function DialogueBox:show()
    self.visible = true
end

function DialogueBox:hide()
    self.visible = false
end

function DialogueBox:isVisible()
    return self.visible
end

function DialogueBox:setDialogue(currDialogue)
    self.currDialogue = currDialogue
end

function DialogueBox:setDialogueTree(currDialogueTree)
    self.currDialogueTree = currDialogueTree
end