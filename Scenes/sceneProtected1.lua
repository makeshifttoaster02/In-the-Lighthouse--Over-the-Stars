SceneProtected1 = Hidable:extend()

function SceneProtected1:new()
    self.text = "Password"
    self.slots = {"_", "_", "_", "_", "_", "_"}
    self.currSlotIndex = 1
    self.fontSize = Terminal:getHeight() / 5
    self.font = love.graphics.newFont("Fonts/Pinscher.otf", self.fontSize)
    self.slotMargin = Terminal:getWidth() / 40
    self.sideMargin = Terminal:getWidth() / 2 - self.font:getWidth("_ _ _ _ _ _") / 2.4

    self.textYMargin = Terminal:getHeight() / 10
    self.textX = 0
    self.textY = self.textYMargin

    self.slotYMargin = Terminal:getHeight() * 2/3 - self.textYMargin
    self.letterCursorPresent = false
    self.letterCursorUpdateDuration = 0.5
    self.letterCursorCurrDuration = 0

    self.hintText = "Hint: Middle"
    self.hintFontSize = self.fontSize / 4
    self.hintFont = love.graphics.newFont("Fonts/Pinscher.otf", self.hintFontSize)
    self.hintX = 0
    self.hintY = self.slotYMargin + self.fontSize + self.textYMargin / 4
end

function SceneProtected1:update(dt, cursorX, cursorY)
    self.letterCursorCurrDuration = self.letterCursorCurrDuration + dt
    if self.letterCursorCurrDuration >= self.letterCursorUpdateDuration then
        self.letterCursorCurrDuration = 0
        self.letterCursorPresent = not self.letterCursorPresent
    end
end

function SceneProtected1:draw()
    love.graphics.printf(self.text, self.font, self.textX, self.textY, Terminal:getWidth(), "center")
    love.graphics.printf(self.hintText, self.hintFont, self.hintX, self.hintY, Terminal:getWidth(), "center")
    local letterX = self.sideMargin - (self.font:getWidth(self.slots[1]) + self.slotMargin)
    for i = 1, #self.slots do
        local currLetter = self.slots[i]
        letterX = letterX + (self.font:getWidth(currLetter) + self.slotMargin)
        local letterY = self.slotYMargin
        love.graphics.print(currLetter, self.font, letterX, letterY)

        if self.letterCursorPresent and i == self.currSlotIndex then
            local yIncrease = Terminal:getHeight() / 300
            while (yIncrease < Terminal:getHeight() / 10) do
                love.graphics.print(currLetter, self.font, letterX, letterY - yIncrease)
                yIncrease = yIncrease + Terminal:getHeight() / 300
            end
        end
    end
end

function SceneProtected1:mousereleased(cursorX, cursorY)
end

function SceneProtected1:keypressed(key)
    if IsAlphanumeric(key) then
        if IsLowercase(key) then
            key = string.upper(key)
        end

        if not (self.currSlotIndex == 7 and self.slots[6] ~= "_") then
            self.slots[self.currSlotIndex] = key
            self.currSlotIndex = self.currSlotIndex + 1
            if self.currSlotIndex == 7 then
                Terminal:hideAll()
                if self:isPasswordCorrect() then
                    Terminal:getHidable("SceneProtected3"):show()
                else
                    Terminal:getHidables()["SceneProtected2"]:show()
                    TEsound.play("Sounds/Incorrect.mp3", "static")
                end
                self.currSlotIndex = 1
                self.slots = {"_", "_", "_", "_", "_", "_"}
            end
        end

    elseif key == "backspace" then
        if not (self.currSlotIndex == 1 and self.slots[1] == "_") then
            self.slots[self.currSlotIndex - 1] = "_"
            self.currSlotIndex = self.currSlotIndex - 1
            if self.currSlotIndex < 1 then
                self.currSlotIndex = 1
            end
        end
    end
end

function SceneProtected1:isPasswordCorrect()
    local potentialPassword = ""
    for _, letter in ipairs(self.slots) do
        potentialPassword = potentialPassword .. letter
    end

    return potentialPassword == "STEFAN"
end