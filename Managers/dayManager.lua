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
                Terminal:getHidable("SceneSos2"):restoreDefaults()
                self.dayInits[self.currDay]()
                SongManager:makeReadyToPlay()
                Taskbar:setDate(self:getDate())
            end
        end
    end
end

function DayManager:keypressed(key)
    local dayNum = tonumber(key)
    local songIndexMapping = {0, 1, 2, 3, 6, 7}
    SongManager:setIndex(songIndexMapping[dayNum])

    DayManager:setDay(dayNum)
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
    SongManager:fadeIntoNext()

    local currChapterCard = CardManager:getChapterCard(day)
    currChapterCard:setFadingIn()
    self.delayLoad = true
    DialogueBox:reset()
    DialogueBox:hide()
end

function DayManager:initDay1()
    Background:freshenDrawables({"Leaf", "Glove1", "Glove2", "Window", "Suit", "Helmet", "Door", "Rocket", "Bed"})
end

function DayManager:initDay2()
    Background:freshenDrawables({"Leaf", "Window", "Suit", "Helmet", "Rocket", "Bed"})
    local entries = {
        SceneMail1Entry3(),
        SceneMail1Entry4(),
        SceneMail1Entry5(),
    }
    Terminal:getHidable("SceneMail1"):setEntries(entries)
end

function DayManager:initDay3()
    Background:freshenDrawables({"Leaf", "Window", "Suit", "Helmet", "Bed"})
    Terminal:getHidable("SceneRadar1"):triggerDay34()
end

function DayManager:initDay4()
    Background:freshenDrawables({"Bed"})
    Terminal:getHidable("SceneRadar1"):triggerDay34()
    Terminal:getHidable("SceneRadar1"):triggerDay4Phase1()
    Background:getDrawable("Bed"):disableClick()
    local entries = {
        SceneMail1Entry4(),
        SceneMail1Entry5(),
    }
    Terminal:getHidable("SceneMail1"):setEntries(entries)
end

function DayManager:initDay5()
    Background:freshenDrawables({"Window", "Suit", "Rocket", "Bed"})
    Terminal:getHidable("SceneRadar1"):triggerDay56()
    Terminal:getHidable("SceneMail1"):setEntries({})
end

function DayManager:initDay6()
    Background:freshenDrawables({"Bed"})
    Terminal:getHidable("SceneRadar1"):triggerDay56()
    Terminal:getHidable("SceneMail1"):setEntries({SceneMail1Entry6()})
end

function DayManager:getDate()
    local dates = {
        "November 22, 2084",
        "November 23, 2084",
        "November 24, 2084",
        "November 25, 2084",
        "January 15, 2085",
        "January 16, 2085",
    }

    return dates[self.currDay]
end