SceneMail1 = Hidable:extend()

function SceneMail1:new()
    self.entries = {
        SceneMail1Entry1(),
        SceneMail1Entry2(),
        SceneMail1Entry3(),
        SceneMail1Entry4(),
        SceneMail1Entry5()
    }

    self.upArrow = love.graphics.newImage("Icons/UpArrow.png")
    self.downArrow = love.graphics.newImage("Icons/DownArrow.png")
    self.desiredIconLength = Terminal:getHeight() / 10

    self.showUpArrow = false
    self.showDownArrow = true

    self.noticeText = "All mail older than five years old will be automatically deleted.\nPlease save and print any important messages."
    self.noticeFontSize = Terminal:getHeight() / 20
    self.noticeFont = love.graphics.newFont("Fonts/Pinscher.otf", self.noticeFontSize)
    self.noticeMargin = Terminal:getHeight() / 10

    self.margin = Terminal:getHeight() / 40
    self.boxX = 0
    self.boxY = self.desiredIconLength + self.margin
    self.boxWidth = Terminal:getWidth()
    self.boxHeight = Terminal:getHeight() - 2 * (self.desiredIconLength + self.margin)

    self.scrollVelocity = self.margin
    self.scrollOffset = 0
    self.minScrollOffset = 0
    local entryHeight = self.entries[1]:getHeight()
    local entryMargin = self.entries[1]:getMargin()
    self.entriesHeight = (entryHeight + entryMargin) * #self.entries + entryMargin
    local totalHeight = self.entriesHeight + self.noticeFontSize + self.noticeMargin * 2
    self.maxScrollOffset = totalHeight - self.boxHeight
end

function SceneMail1:update(dt, cursorX, cursorY)
    self.showUpArrow = self.scrollOffset > self.minScrollOffset
    self.showDownArrow = self.scrollOffset < self.maxScrollOffset
    if self.visible then
        for i = 1, #self.entries do
            local currEntry = self.entries[i]
            if self:withinBox(cursorX, cursorY) then
                currEntry:markHovering(cursorX, cursorY)
            end
        end
    end
end

function SceneMail1:draw()
    if self.visible then
        love.graphics.setScissor(self.boxX, self.boxY, self.boxWidth, self.boxHeight)
        for i = 1, #self.entries do
            local currEntry = self.entries[i]
            currEntry:draw()
        end
        love.graphics.printf(self.noticeText, self.noticeFont, 0, self.entriesHeight + self.noticeMargin - self.scrollOffset, Terminal:getWidth(), "center")
        love.graphics.setScissor()

        if self.showUpArrow then
            local upSx = self.desiredIconLength / self.upArrow:getWidth()
            local upSy = self.desiredIconLength / self.upArrow:getHeight()
            local upX = Terminal:getWidth() / 2 - self.desiredIconLength / 2
            local upY = self.boxY - self.desiredIconLength - self.margin * 1/2
            love.graphics.draw(self.upArrow, upX, upY, 0, upSx, upSy)
        end

        if self.showDownArrow then
            local downSx = self.desiredIconLength / self.downArrow:getWidth()
            local downSy = self.desiredIconLength / self.downArrow:getHeight()
            local downX = Terminal:getWidth() / 2 - self.desiredIconLength / 2
            local downY = self.boxY + self.boxHeight + self.margin * 1/2
            love.graphics.draw(self.downArrow, downX, downY, 0, downSx, downSy)
        end
    end
end

function SceneMail1:mousereleased(cursorX, cursorY)
    if self.visible then
        for i = 1, #self.entries do
            local currEntry = self.entries[i]
            if self:withinBox(cursorX, cursorY) then
                if currEntry:withinBounds(cursorX, cursorY) then
                    currEntry:mousereleased(cursorX, cursorY)
                    break
                end
            end
        end
    end
end

function SceneMail1:wheelmoved(y)
    if self.visible then
        if y > 0 then
            self.scrollOffset = math.max(self.minScrollOffset, self.scrollOffset - y * self.scrollVelocity)
        else
            self.scrollOffset = math.min(self.scrollOffset - y * self.scrollVelocity, self.maxScrollOffset)
        end
    end
end

function SceneMail1:keypressed(key)
    if self.visible then
        if key == "up" or key == "w" then
            self:wheelmoved(1)
        elseif key == "down" or key == "s" then
            self:wheelmoved(-1)
        end
    end
end

function SceneMail1:getScrollOffset()
    return self.scrollOffset
end

function SceneMail1:restoreDefaults()
    -- self.scrollOffset = 0
end

function SceneMail1:withinBox(cursorX, cursorY)
    local canvasX = cursorX - Terminal:getX()
    local canvasY = cursorY - Terminal:getY()
    return self.boxX <= canvasX and canvasX <= self.boxX + self.boxWidth and self.boxY <= canvasY and canvasY <= self.boxY + self.boxHeight 
end