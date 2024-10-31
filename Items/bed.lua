Bed = Item:extend()

function Bed:new()
    local images = {
        love.graphics.newImage("Assets/Bed 1.png"),
        love.graphics.newImage("Assets/Bed 2.png"),
    }

    local imageX = 0
    local imageY = 0
    local clickable = true

    local imageSx = love.graphics.getWidth() / images[1]:getWidth()
    local imageSy = love.graphics.getHeight() / images[1]:getHeight()

    local unscaledAssetX, unscaledAssetY, unscaledAssetWidth, unscaledAssetHeight = table.unpack({1455 - 2559, 591, 998, 663})
    local assetX = unscaledAssetX * imageSx
    local assetY = unscaledAssetY * imageSy
    local assetWidth = unscaledAssetWidth * imageSx
    local assetHeight = unscaledAssetHeight * imageSy

    local dialogueTree = DialogueTree(
        {
            [1] =

            {
                {"Daniel", "Go to sleep?"}
            }
        }
    )

    -- self.decision = BedDecision()

    Bed.super.new(self, images, imageX, imageY, clickable, assetX, assetY, assetWidth, assetHeight, dialogueTree)
end

function Bed:mousereleased(cursorX, cursorY)
    if self:withinBounds(cursorX, cursorY) and DayManager:getDay() ~= 6 then
        DayManager:nextDay()
    end
    -- if self:withinBounds(cursorX, cursorY) then
    --     self.fresh = true
    --     self.decision:show()
    -- end
end