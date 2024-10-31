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

    self.delayLoad = false
    self.readyToPlaySong = true

    self.cardStayDuration = 5
    self.currStayDuration = 0
end

function DayManager:update(dt)
    local currChapterCard = CardManager:getChapterCard(self.currDay)
    if currChapterCard:isFadingIn() then
        self.currStayDuration = self.currStayDuration + dt
        if self.currStayDuration >= self.cardStayDuration then
            self.currStayDuration = 0
            currChapterCard:setFadingOut()
            Game:removeStart()
            OffsetManager:setOffset(0)
            if self.delayLoad then
                self.delayLoad = false
                Terminal:hideAll()
                Terminal:getHidable("Menu"):show()
                Terminal:getHidable("SceneMail1"):resetScrollOffset()
                self.dayInits[self.currDay]()
            end

            if self.readyToPlaySong then
                self.readyToPlaySong = false
                SongManager:play(self.currDay)
                SongManager:fadeIn()
            end
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
    SongManager:fadeOut()

    local currChapterCard = CardManager:getChapterCard(day)
    currChapterCard:setFadingIn()
    self.delayLoad = true
end

function DayManager:initDay1()
    Background:freshenDrawables({"Leaf", "Glove1", "Glove2", "Window", "Suit", "Helmet", "Door", "Rocket", "Bed"})
end

function DayManager:initDay2()
    Background:freshenDrawables({"Leaf", "Window", "Suit", "Helmet", "Rocket", "Bed"})
end

function DayManager:initDay3()
    Background:freshenDrawables({"Leaf", "Window", "Suit", "Helmet", "Bed"})
    Terminal:getHidable("SceneRadar1"):triggerDay34()
end

function DayManager:initDay4()
    Background:freshenDrawables({"Leaf", "Bed"})
    Terminal:getHidable("SceneRadar1"):triggerDay34()
end

function DayManager:initDay5()
    Background:freshenDrawables({"Leaf", "Window", "Suit", "Rocket", "Bed"})
    Terminal:getHidable("SceneRadar1"):triggerDay56()
end

function DayManager:initDay6()
    Background:freshenDrawables({"Leaf", "Bed"})
    Terminal:getHidable("SceneRadar1"):triggerDay56()
end

function DayManager:readyToPlay()
    self.readyToPlaySong = true
end