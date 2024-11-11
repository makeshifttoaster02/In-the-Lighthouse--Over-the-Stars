Leaf = Item:extend()

function Leaf:new()
    local images = {
        love.graphics.newImage("Assets/Leaf 1.png"),
        love.graphics.newImage("Assets/Leaf 2.png"),
    }

    local imageX = 0
    local imageY = 0
    local clickable = true

    local imageSx = love.graphics.getWidth() / images[1]:getWidth()
    local imageSy = love.graphics.getHeight() / images[1]:getHeight()

    local unscaledAssetX, unscaledAssetY, unscaledAssetWidth, unscaledAssetHeight = table.unpack({2150 - 2559, 274, 121, 88})
    local assetX = unscaledAssetX * imageSx
    local assetY = unscaledAssetY * imageSy
    local assetWidth = unscaledAssetWidth * imageSx
    local assetHeight = unscaledAssetHeight * imageSy

    local dialogueTree = DialogueTree(
        {
            [1] =

            {
                {"Daniel", "On the last night we all lived under one roof, we carved N-D-G on our old lime tree, daring tomorrow never to come."}
            },

            [2] =

            {
                {"Daniel", "On the last night we all lived under one roof, we carved N-D-G on our old lime tree, daring tomorrow never to come."}
            },

            [3] =

            {
                {"Daniel", "On the last night we all lived under one roof, we carved N-D-G on our old lime tree, daring tomorrow never to come."}
            },

            [4] =

            {
                {"Daniel", "On the last night we all lived under one roof, we carved N-D-G on our old lime tree, daring tomorrow never to come."}
            },

            [5] =

            {
                {"Daniel", "On the last night we all lived under one roof, we carved N-D-G on our old lime tree, daring tomorrow never to come."}
            },

            [6] =

            {
                {"Daniel", "On the last night we all lived under one roof, we carved N-D-G on our old lime tree, daring tomorrow never to come."}
            }
        }
    )

    Leaf.super.new(self, images, imageX, imageY, clickable, assetX, assetY, assetWidth, assetHeight, dialogueTree)
end

function Leaf:dialogueChangeMid4()
    local dialogueTree = self:getDialogueTree()
    local dialogueList = dialogueTree:getDialogueList()
    local new4 = {
        {"Daniel", "One time, Nana made a quilt for us."},
        {"Daniel", "On cold winter nights, we would all huddle under one blanket and fall asleep in each other's warmth."},
        {"Daniel", "Nana, Gael - \nI miss you guys so much."},
        {"Daniel", "I just want to go home."},
    }

    dialogueList[4] = new4
    dialogueTree:setDialogueList(dialogueList)
    self:setDialogueTree(dialogueTree)
    self.fresh = true
end