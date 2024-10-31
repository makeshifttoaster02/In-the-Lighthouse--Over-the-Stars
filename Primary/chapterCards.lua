ChapterCards = {
    ChapterCard(1, "Lost"),
    ChapterCard(2, "What Once Was"),
    ChapterCard(3, "The Abyss Stares Back"),
    ChapterCard(4, "Found"),
    ChapterCard(5, "Be Still, My Beating Heart"),
    ChapterCard(6, "In The Lighthouse Over the Stars")
}

function ChapterCards:hasActive()
    for _, card in ipairs(self) do
        if card:getOpacity() > 0 then
            return true
        end
    end

    return false
end