DayManager = Object:extend()

function DayManager:load()
    self.currDay = 1
    self.dayInits = {
        function() self:initDay1() end,
        function() self:initDay2() end,
        function() self:initDay3() end,
        function() self:initDay4() end,
        function() self:initDay5() end,
        function() self:initDay6() end,
    }

    self.cardStayDuration = 3
    self.currStayDuration = 0
end

function DayManager:update(dt)
    if ChapterCards[self.currDay]:isFadingIn() then
        self.currStayDuration = self.currStayDuration + dt
        if self.currStayDuration >= self.cardStayDuration then
            self.currStayDuration = 0
            ChapterCards[self.currDay]:setFadingOut()
            Game:removeStart()
            Game:setOffset(0)
        end
    end
end

function DayManager:getDay()
    return self.currDay
end

function DayManager:setDay(day)
    self.currDay = day
    self:initDay(day)
end

function DayManager:nextDay()
    self:setDay(self.currDay + 1)
end

function DayManager:initDay(day)
    ChapterCards[day]:setFadingIn()
    self.dayInits[day]()
end

function DayManager:initDay1()
    Background:freshenDrawables({"Leaf", "Glove1", "Glove2", "Window", "Suit", "Helmet", "Door", "Rocket", "Bed"})
end

function DayManager:initDay2()
    Background:freshenDrawables({"Leaf", "Window", "Suit", "Helmet", "Rocket", "Bed"})
end

function DayManager:initDay3()
    Background:freshenDrawables({"Leaf", "Window", "Suit", "Helmet", "Bed"})
end

function DayManager:initDay4()
    Background:freshenDrawables({"Leaf", "Bed"})
end

function DayManager:initDay5()
    Background:freshenDrawables({"Leaf", "Window", "Suit", "Rocket", "Bed"})
end

function DayManager:initDay6()
    Background:freshenDrawables({"Leaf", "Bed"})
end