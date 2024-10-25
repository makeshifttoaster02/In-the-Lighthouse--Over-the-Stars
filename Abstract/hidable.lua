Hidable = Object:extend()

function Hidable:new()
    self.visible = false
end

function Hidable:show()
    self:restoreDefaults()
    self.visible = true
end

function Hidable:hide()
    self.visible = false
end

function Hidable:isVisible()
    return self.visible
end

function Hidable:mousereleased(cursorX, cursorY)
end

function Hidable:wheelmoved(y)
end

function Hidable:keypressed(key)
end

function Hidable:textinput(t)
end

function Hidable:restoreDefaults()

end

function Hidable:isMailMessage()
    return false
end