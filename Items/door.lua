Door = Item:extend()

function Door:new()
    local images = {
        love.graphics.newImage("Assets/Door 1.png"),
        love.graphics.newImage("Assets/Door 2.png"),
    }

    local imageX = love.graphics.getWidth() * 2
    local imageY = 0
    local clickable = true

    local imageSx = love.graphics.getWidth() / images[1]:getWidth()
    local imageSy = love.graphics.getHeight() / images[1]:getHeight()

    local unscaledAssetX, unscaledAssetY, unscaledAssetWidth, unscaledAssetHeight = table.unpack({794 + 2559, 141, 895, 1163})
    local assetX = unscaledAssetX * imageSx
    local assetY = unscaledAssetY * imageSy
    local assetWidth = unscaledAssetWidth * imageSx
    local assetHeight = unscaledAssetHeight * imageSy

    local dialogueTree = DialogueTree(
        {
            [1] =

            {
                {"Daniel", "Door to the cosmos."},
                {"Daniel", "I'd love to go out, stretch my legs, and see the stars some time, but opening this door would depressurize the lighthouse."},
                {"Daniel", "I don't want to take any chances."}
            },

            [2] =

            {
                {"Daniel", "Door to the cosmos."},
                {"Daniel", "I'd love to go out, stretch my legs, and see the stars some time, but opening this door would depressurize the lighthouse."},
                {"Daniel", "I don't want to take any chances."}
            },

            [3] =

            {
                {"Daniel", "Door to the cosmos."},
                {"Daniel", "I'd love to go out, stretch my legs, and see the stars some time, but opening this door would depressurize the lighthouse."},
                {"Daniel", "I don't want to take any chances."}
            },

            [4] =

            {
                {"Daniel", "Door to the cosmos."},
            },

            [5] =

            {
                {"Daniel", "Door to the nether."},
            },

            [6] =

            {
                {"Daniel", "Door to the nether."},
            },
        }
    )

    Door.super.new(self, images, imageX, imageY, clickable, assetX, assetY, assetWidth, assetHeight, dialogueTree)
end

function Door:dialogueChangeMid6()
    local dialogueTree = self:getDialogueTree()
    local dialogueList = dialogueTree:getDialogueList()
    local new6 = {
        {"Daniel", "Witness the end?"},
        {"Daniel", "If you do this, your journey will truly be over. Are you sure?"}
    }

    dialogueList[6] = new6
    dialogueTree:setDialogueList(dialogueList)
    self:setDialogueTree(dialogueTree)
    self.fresh = true
    self.eternallyFresh = true
end