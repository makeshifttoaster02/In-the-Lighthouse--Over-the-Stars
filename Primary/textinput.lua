TextInput = class('TextInput')

function TextInput:initialize(x, y, size, w, callback)
    self.text = ""
    self.time = 0.0
    self.cursor = "|"
    self.cursor_pos = 0
    self.x = x
    self.y = y
    self.size = size
    self.w = w
    self.callback = callback
    self.shift = false
end

function TextInput:reset()
    self.shift = false
    self.cursor_pos = 0
    self.time = 0.0
    self.text = ""
end

function TextInput:step(dt)
    self.time = self.time + dt
    if self.time > 0.5 then
        if self.cursor == "|" then
            self.cursor = ""
        else
            self.cursor = "|"
        end
        self.time = 0.0
    end
    self.shift = love.keyboard.isDown("lshift", "rshift", "capslock")
end

function TextInput:keypressed(key)
    if key == "backspace" and self.cursor_pos > 0 then
        self.text = string.sub(self.text, 1, self.cursor_pos-1) .. string.sub(self.text, self.cursor_pos+1)
        self.cursor_pos = self.cursor_pos-1
    elseif key == "left" then
        self.cursor_pos = math.max(0, self.cursor_pos-1)
    elseif key == "right" then
        self.cursor_pos = math.min(self.text:len(), self.cursor_pos+1)
    elseif key == "delete" then
        self.text = string.sub(self.text, 1, self.cursor_pos) .. string.sub(self.text, self.cursor_pos+2)
    elseif key == "return" then
        self.text = string.sub(self.text, 1, self.cursor_pos) .. "\n" .. string.sub(self.text, self.cursor_pos+1)
        self.cursor_pos = self.cursor_pos + 1
    end
end

function TextInput:textinput(t)
    if self.text:len() < self.size then
        self.text = string.sub(self.text, 1, self.cursor_pos) .. t .. string.sub(self.text, self.cursor_pos+1)
        self.cursor_pos = self.cursor_pos + 1
    end
end

function TextInput:draw()
    love.graphics.printf(self.text, self.x, self.y, self.w)

    local cursor_x, cursor_y = self.x, self.y
    local font = love.graphics.getFont()
    local text_up_to_cursor = string.sub(self.text, 1, self.cursor_pos)

    local wrapped_text, lines = font:getWrap(text_up_to_cursor, self.w)
    cursor_y = self.y + (#lines - 1) * font:getHeight() - font:getHeight() / 4.1
    cursor_x = self.x + font:getWidth(lines[#lines]) - font:getHeight() / 5
    love.graphics.printf(
        self.cursor,
        cursor_x,
        cursor_y,
        self.w
    )
end

function TextInput:setX(x)
    self.x = x
end

function TextInput:setY(y)
    self.y = y
end

function TextInput:getText()
    return self.text
end

function TextInput:setText(text)
    self.text = text
end