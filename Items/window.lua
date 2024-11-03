Window = Item:extend()

function Window:new()
    local images = {
        love.graphics.newImage("Assets/Window 1.png"),
        love.graphics.newImage("Assets/Window 2.png"),
    }

    local imageX = love.graphics.getWidth()
    local imageY = 0
    local clickable = true

    local imageSx = love.graphics.getWidth() / images[1]:getWidth()
    local imageSy = love.graphics.getHeight() / images[1]:getHeight()

    local unscaledAssetX, unscaledAssetY, unscaledAssetWidth, unscaledAssetHeight = table.unpack({2134, 868, 378, 358})
    local assetX = unscaledAssetX * imageSx
    local assetY = unscaledAssetY * imageSy
    local assetWidth = unscaledAssetWidth * imageSx
    local assetHeight = unscaledAssetHeight * imageSy

    local dialogueTree = DialogueTree(
        {
            [1] =

            {
                {"Daniel", "Outside the window, debris intermingles with the stars."}
            },

            [2] =

            {
                {"Daniel", "I used to grow frustrated when I'd peek out the window and see debris floating around."},
                {"Daniel", "There's no aerodynamic drag in space, so all sorts of junk can end up on the far outreaches of the universe.\n\nThen it crashes into our satelites and lighthouses, creating more debris and making a mess."},
                {"Daniel", "People really just throw away weird stuff and dump all their trash in space without thinking about the people who have to clean it up."},
                {"Daniel", "Although, to be fair, people do that back on Earth, too. Some things never change."},
            },

            [3] =

            {
                {"Daniel", "Gael once asked when I decided I wanted to work in space."},
                {"Daniel", "I told him the story.\n\n\"It was during Ms. Iselda's class, on the school trip to the moon. I was in the rocket on the way over, looking at the world from the window.\""},
                {"Daniel", "\"I just started crying. I cried and cried and cried. I wondered to myself, 'Why are there divisions between us? Why did it have to be this way?' \""},
                {"Daniel", "\"From up here, you can't see any borders. All you can see is Earth.\""},
            },

            [4] =

            {
                {"Daniel", "Outside the window, debris intermingles with the stars."}
            },

            [5] =

            {
                {"Daniel", "Outside the window, debris intermingles with the stars. White streaks of light fill the void."}
            },

            [6] =

            {
                {"Daniel", "Outside the window, debris intermingles with the stars. White streaks of light fill the void."}
            },
        }
    )

    Window.super.new(self, images, imageX, imageY, clickable, assetX, assetY, assetWidth, assetHeight, dialogueTree)
end

function Window:dialogueChangeMid6()
    local dialogueTree = self:getDialogueTree()
    local dialogueList = dialogueTree:getDialogueList()
    local new6 = {
        {"Daniel", "Outside the window, wisps of starlight brush against the hull of the lighthouse."},
        {"Daniel", "In this lighthouse over the stars, I've made my peace."},
        {"Daniel", "It's time to go."},
    }

    dialogueList[6] = new6
    dialogueTree:setDialogueList(dialogueList)
    self:setDialogueTree(dialogueTree)
    self.fresh = true
end