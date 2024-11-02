CardManager = Object:extend()

function CardManager:load()
    self.chapterCards = {
        ChapterCard(1, "Lost"),
        ChapterCard(2, "What Once Was"),
        ChapterCard(3, "The Abyss Stares Back"),
        ChapterCard(4, "Found"),
        ChapterCard(5, "Be Still, My Beating Heart"),
        ChapterCard(6, "In The Lighthouse Over the Stars")
    }
end

function CardManager:update(dt)
    for _, card in ipairs(self.chapterCards) do
        card:update(dt)
    end
end

function CardManager:draw()
    for day, card in ipairs(self.chapterCards) do
        if DayManager:getDay() == day then
            card:draw()
            break
        end
    end
end

function CardManager:hasActive()
    for _, card in ipairs(self.chapterCards) do
        if card:getOpacity() > 0 then
            return true
        end
    end

    return false
end

function CardManager:hasSemiActive()
    for _, card in ipairs(self.chapterCards) do
        if card:getOpacity() > 0.6 then
            return true
        end
    end

    return false
end

function CardManager:getChapterCard(day)
    return self.chapterCards[day]
end