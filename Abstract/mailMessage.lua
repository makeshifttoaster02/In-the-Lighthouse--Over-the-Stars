MailMessage = Hidable:extend()

function MailMessage:new(text, cantReply, cantReplyText, messageName)
    self.text = text .. "\n"
    self.cantReply = cantReply
    self.cantReplyText = cantReplyText
    self.messageName = messageName

    self.fontSize = Terminal:getHeight() / 15
    self.font = love.graphics.newFont("Fonts/Pinscher.otf", self.fontSize)

    self.upArrow = love.graphics.newImage("Icons/UpArrow.png")
    self.downArrow = love.graphics.newImage("Icons/DownArrow.png")
    self.desiredIconLength = Terminal:getHeight() / 10

    self.margin = Terminal:getHeight() / 20
    self.x = 2 * self.margin
    self.y = 3 * self.margin
    self.width = Terminal:getWidth() - 4 * self.margin

    self.textboxX = self.x
    self.textboxY = self.y
    self.textboxWidth = self.width
    self.textboxHeight = Terminal:getHeight() - 2 * self.desiredIconLength - 2 * self.margin

    self.scrollVelocity = self.margin
    self.scrollOffset = 0
    self.minScrollOffset = 0
    local _, wrappedText = self.font:getWrap(self.text, self.textboxWidth)
    self.totalTextHeight = self.font:getHeight() * #wrappedText

    self.showUpArrow = false
    self.showDownArrow = true

    self.replyButton = ReplyButton(self.x, self.y + self.totalTextHeight, "Reply")
    self.replyButton:setX((Terminal:getWidth() - self.replyButton:getWidth()) / 2)

    self.replyInputActive = false
    self.replyBoxWidth = self.textboxWidth - 2 * self.margin
    self.replyBoxInput = TextInput(
        0,
        0,
        50000,
        self.replyBoxWidth - 2 * self.margin,
        function()
        end
    )
    self.replyBoxFontSize = Terminal:getHeight() / 30
    self.replyBoxFont = love.graphics.newFont("Fonts/Pinscher.otf", self.replyBoxFontSize)
    self.replyBoxRadius = 10
    self.replySignature = [[


_____________

Daniel Moreno
Debris Salvager
Division 3099
DNLMRN#707605]]
    self.replyBoxInput:setText(self.replySignature)
    local _, wrappedReplyText = self.replyBoxFont:getWrap(self.replyBoxInput:getText(), self.replyBoxWidth - 2 * self.margin)
    self.replyBoxHeight = self.replyBoxFont:getHeight() * #wrappedReplyText + 2 * self.margin

    self.cancelMargin = Terminal:getHeight() / 40
    self.cancelButton = CancelButton(0, 0, "Cancel")

    self.sendMargin = self.cancelMargin
    self.sendButton = SendButton(0, 0, "Send")
    self.sending = false
    self.sendingText = "Sending ..."
    self.sendingTextFontSize = Terminal:getHeight() / 30
    self.sendingTextFont = love.graphics.newFont("Fonts/Pinscher.otf", self.sendingTextFontSize)
    self.sendingDuration = 0.5
    self.currSendingDuration = 0
    self.failedDuration = math.random(4, 8)
    self.currFailedDuration = 0

    self.hasGael = (messageName == "SceneMail1Message6")
    self.gael = GaelAttachment()
end

function MailMessage:update(dt, cursorX, cursorY)
    self.showUpArrow = self.scrollOffset > self.minScrollOffset
    self.showDownArrow = self.scrollOffset < self:getMaxScrollOffset()

    if self.visible then
        if self.replyButton:isVisible() then
            self.replyButton:markHovering(cursorX, cursorY)
        else
            self.cancelButton:markHovering(cursorX, cursorY)
            self.sendButton:markHovering(cursorX, cursorY)
            if self.sending then
                self.currFailedDuration = self.currFailedDuration + dt
                self.currSendingDuration = self.currSendingDuration + dt
                if self.currSendingDuration >= self.sendingDuration then
                    self.currSendingDuration = 0
                    self.sendingText = self.sendingText .. "."
                    if self.sendingText == "Sending ...." then
                        self.sendingText = "Sending ."
                    end
                end

                if self.currFailedDuration >= self.failedDuration then
                    self.sendingText = "Failed to send. Please try again later."
                end
            end
        end

        if self.hasGael then
            self.gael:markHovering(cursorX, cursorY)
        end
    end

    if self.replyInputActive then
        self.replyBoxInput:step(dt)
    end
end

function MailMessage:draw()
    if self.visible then
        local textY = self.y - self.scrollOffset
        love.graphics.setScissor(self.textboxX, self.textboxY, self.textboxWidth, self.textboxHeight)
        love.graphics.printf(self.text, self.font, self.x, textY, self.width, "left")
        if not self.cantReply then
            if self.replyButton:isVisible() then
                self.replyButton:setY(textY + self.totalTextHeight)
                self.replyButton:draw()
            else
                local replyBoxX = self.textboxX + self.margin
                local replyBoxY = textY + self.totalTextHeight
                SetColorHEX("#FFFFFF")
                love.graphics.rectangle("fill", replyBoxX, replyBoxY, self.replyBoxWidth, self.replyBoxHeight, self.replyBoxRadius)
                self.replyBoxInput:setX(replyBoxX + self.margin)
                self.replyBoxInput:setY(replyBoxY + self.margin)
                SetColorHEX("#000000")
                love.graphics.setFont(self.replyBoxFont)
                self.replyBoxInput:draw()
                SetColorHEX("#FFFFFF")

                local cancelX = replyBoxX + self.replyBoxWidth - self.cancelButton:getWidth() - self.margin
                local cancelY = replyBoxY + self.replyBoxHeight + self.cancelMargin
                self.cancelButton:setX(cancelX)
                self.cancelButton:setY(cancelY)
                self.cancelButton:draw()

                local sendX = cancelX - self.cancelButton:getWidth() - self.sendMargin
                local sendY = cancelY
                self.sendButton:setX(sendX)
                self.sendButton:setY(sendY)
                self.sendButton:draw()

                local sendingTextCheck = self.sendingText
                if (self.sendingText == "Sending .." or self.sendingText == "Sending .") then
                    sendingTextCheck = "Sending ..."
                end
                local sendingTextX = sendX - 2 * self.sendMargin - self.sendingTextFont:getWidth(sendingTextCheck)
                local sendingTextY = sendY + self.cancelButton:getHeight() / 2 - self.sendingTextFontSize / 2
                love.graphics.print(self.sendingText, self.sendingTextFont, sendingTextX, sendingTextY)
            end
        else
            if self.hasGael then
                self.gael:draw()
            else
                love.graphics.printf(self.cantReplyText, self.sendingTextFont, self.x, textY + self.totalTextHeight, self.textboxWidth, "center")
            end
        end
        love.graphics.setScissor()

        if self.showUpArrow then
            local upSx = self.desiredIconLength / self.upArrow:getWidth()
            local upSy = self.desiredIconLength / self.upArrow:getHeight()
            local upX = Terminal:getWidth() / 2 - self.desiredIconLength / 2
            local upY = self.textboxY - self.desiredIconLength - self.margin * 1/2
            love.graphics.draw(self.upArrow, upX, upY, 0, upSx, upSy)
        end

        if self.showDownArrow then
            local downSx = self.desiredIconLength / self.downArrow:getWidth()
            local downSy = self.desiredIconLength / self.downArrow:getHeight()
            local downX = Terminal:getWidth() / 2 - self.desiredIconLength / 2
            local downY = self.textboxY + self.textboxHeight + self.margin * 1/2
            love.graphics.draw(self.downArrow, downX, downY, 0, downSx, downSy)
        end

    end
end

function MailMessage:mousereleased(cursorX, cursorY)
    if self.visible then
        if self.hasGael then
            self.gael:mousereleased(cursorX, cursorY)
        else
            if self.replyButton:isVisible() then
                self.replyButton:mousereleased(cursorX, cursorY, self.messageName)
            else
                self.cancelButton:mousereleased(cursorX, cursorY, self.messageName)
                self.sendButton:mousereleased(cursorX, cursorY, self.messageName)
            end
        end
    end
end

function MailMessage:wheelmoved(y)
    if y > 0 then
        self.scrollOffset = math.max(self.minScrollOffset, self.scrollOffset - y * self.scrollVelocity)
    else
        self.scrollOffset = math.min(self.scrollOffset - y * self.scrollVelocity, self:getMaxScrollOffset())
    end
end

function MailMessage:keypressed(key)
    if not self.replyInputActive then
        if key == "up" then
            self:wheelmoved(1)
        elseif key == "down" then
            self:wheelmoved(-1)
        end
    else
        self.replyBoxInput:keypressed(key)
        self:setReplyBoxHeight()
        self:setToMaxOffset()
    end
end

function MailMessage:textinput(t)
    if self.replyInputActive then
        self.replyBoxInput:textinput(t)
        self:setReplyBoxHeight()
        self:setToMaxOffset()
    end
end

function MailMessage:isMailMessage()
    return true
end

function MailMessage:restoreDefaults()
    self.scrollOffset = 0
    self:deactivateReplyInput()
end

function MailMessage:getScrollOffset()
    return self.scrollOffset
end

function MailMessage:getMaxScrollOffset()
    if self.hasGael then
        return self.totalTextHeight + self.gael:getMargin() + self.gael:getHeight() + self.replyButton:getHeight() - self.textboxHeight
    end

    if self.replyButton:isVisible() then
        return self.totalTextHeight + self.replyButton:getHeight() - self.textboxHeight + self.cancelMargin
    end

    return self.totalTextHeight + self.replyBoxHeight + self.cancelButton:getHeight() + 3 * self.cancelMargin - self.textboxHeight
end

function MailMessage:setToMaxOffset()
    self.scrollOffset = self:getMaxScrollOffset()
end

function MailMessage:activateReplyInput()
    self.replyInputActive = true
    self.replyButton:hide()
end

function MailMessage:deactivateReplyInput()
    self.replyInputActive = false
    self.replyButton:show()
    self.replyBoxInput:reset()
    self.replyBoxInput:setText(self.replySignature)
    self.sendingText = ""
    self.failedDuration = math.random(4, 8)
    self.currFailedDuration = 0
    self.currSendingDuration = 0
    self.sending = false
end

function MailMessage:setReplyBoxHeight()
    local _, wrappedReplyText = self.replyBoxFont:getWrap(self.replyBoxInput:getText(), self.replyBoxWidth - 2 * self.margin)
    self.replyBoxHeight = self.replyBoxFont:getHeight() * #wrappedReplyText + 2 * self.margin
end

function MailMessage:setSending()
    self.sending = true
    self.sendingText = "Sending ."
    self.currSendingDuration = 0
    self.currFailedDuration = 0
    self.failedDuration = math.random(4, 8)
end

function MailMessage:isReplyInputActive()
    return self.replyInputActive
end

function MailMessage:getTotalTextHeight()
    return self.totalTextHeight
end

function MailMessage:getGaelY()
    return self.totalTextHeight + self.y - self.scrollOffset
end