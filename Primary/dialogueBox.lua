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

    self.currDialogueSubstr = ""
    self.currDialogueIndex = 0
    self.characterDuration = 0.025
    self.currCharacterDuration = 0

    self.decisionStrings = {
        ["Go to sleep?"] = true,
        ["Witness the end?"] = true,
        ["If you do this, your journey will truly be over. Are you sure?"] = true
    }

    self.yesButton = YesButton()
    self.noButton = NoButton()
    self.displayDecisionButtonDuration = 0.3
    self.currDecisionButtonDuration = 0
end

function DialogueBox:update(dt, cursorX, cursorY)
    if self.visible then
        if self.currDialogueSubstr ~= self.currDialogue then
            self.currDecisionButtonDuration = 0
            self.currCharacterDuration = self.currCharacterDuration + dt
            if self.currCharacterDuration >= self.characterDuration then
                self.currDialogueIndex = self.currDialogueIndex + 1
                self.currCharacterDuration = 0

                local character = self.currDialogue:sub(self.currDialogueIndex, self.currDialogueIndex)
                self.currDialogueSubstr = self.currDialogueSubstr .. character
                if character == "," or character == "-" then
                    self.characterDuration = 0.12
                elseif character == "." or character == "?" then
                    self.characterDuration = 0.18
                else
                    self.characterDuration = 0.025
                end

                if self.currDialogueIndex ~= string.len(self.currDialogue) then
                    local puncQuotSubstr = self.currDialogue:sub(self.currDialogueIndex, self.currDialogueIndex + 1)
                    if puncQuotSubstr == ".\"" or puncQuotSubstr == "?\"" then
                        self.characterDuration = 0.03
                    end
                end

                -- TEsound.stop("Daniel")
                TEsound.play("Sounds/Daniel.mp3", "static", "Daniel", 4)
            end
        else
            self.currDecisionButtonDuration = self.currDecisionButtonDuration + dt
            if self.currDecisionButtonDuration >= self.displayDecisionButtonDuration then
                self.yesButton:markHovering(cursorX, cursorY)
                self.noButton:markHovering(cursorX, cursorY)
            end
        end
    end
end

function DialogueBox:draw()
    if self.visible then
        SetColorHEX("#000000")
        love.graphics.rectangle("fill", self.boxX, self.boxY, self.boxWidth, self.boxHeight, self.boxRadius)
        love.graphics.setLineWidth(3)
        SetColorHEX("#FFFFFF")
        love.graphics.rectangle("line", self.boxX, self.boxY, self.boxWidth, self.boxHeight, self.boxRadius)

        if self.hovering then
            love.graphics.rectangle("fill", self.boxX, self.boxY, self.boxWidth, self.boxHeight, self.boxRadius)
            local blackShader = Terminal:getInvertShader()
            love.graphics.setShader(blackShader)
        end

        local dialogueX = self.boxX + self.innerBoxXMargin
        local dialogueY = self.boxY + self.innerBoxYMargin
        local dialogueWidth = self.boxWidth - 2 * self.innerBoxXMargin
        love.graphics.printf(self.currDialogueSubstr, self.boxFont, dialogueX, dialogueY, dialogueWidth, "left")

        love.graphics.setShader()

        if self:onDecisionString() then
            if self.currDecisionButtonDuration >= self.displayDecisionButtonDuration then
                self.noButton:draw()
                self.yesButton:draw()
            end
        end

        love.graphics.setShader()
    end
end

function DialogueBox:mousereleased(cursorX, cursorY)
    if self.visible and string.len(self.currDialogueSubstr) >= math.min(string.len(self.currDialogue), 5) then
        if self:withinBounds(cursorX, cursorY) and not self:onDecisionString() then
            self.currDialogueTree:trigger()
        end

        if self:onDecisionString() then
            self.hovering = false
            self.yesButton:mousereleased(cursorX, cursorY)
            self.noButton:mousereleased(cursorX, cursorY)
        end
    end
end

function DialogueBox:keypressed(key)
    if self.visible and key == "escape" then
        self.currDialogueTree:escape()
    end
end

function DialogueBox:markHovering(cursorX, cursorY)
    if self.visible then
        if not self:onDecisionString() then
            if self:withinBounds(cursorX, cursorY) then
                -- if not self.hovering then
                --     TEsound.play("Sounds/Hover.wav", "static")
                -- end
                self.hovering = true
                Game:setHovering()
            else
                self.hovering = false
            end
        end
    end
end

function DialogueBox:onDecisionString()
    return self.decisionStrings[self.currDialogue] or false
end

function DialogueBox:reset()
    self.currDialogueSubstr = ""
    self.currDialogueIndex = 0
    self.currCharacterDuration = 0
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

function DialogueBox:getBoxX()
    return self.boxX
end

function DialogueBox:getBoxY()
    return self.boxY
end

function DialogueBox:getBoxWidth()
    return self.boxWidth
end

function DialogueBox:getBoxHeight()
    return self.boxHeight
end

function DialogueBox:getBoxFontSize()
    return self.boxFontSize
end

function DialogueBox:getCurrDialogueTree()
    return self.currDialogueTree
end

function DialogueBox:setNotHovering()
    self.hovering = false
end