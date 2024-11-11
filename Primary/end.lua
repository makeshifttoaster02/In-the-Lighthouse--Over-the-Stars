End = Object:extend()

function End:load()
    self.blackCardOpacity = 0
    self.blackCardFadingIn = false
    self.blackCardFadeSpeed = 0.2
    self.readyToEnd = false

    self.canvasFadeSpeed = 0.06
    self.backgroundCanvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
    self.combinedCanvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
    self.fadeOutOpacity = 0
    self.fadeInOpacity = 0
    self.fadeIntoNextScene = false
    self.sceneDraws ={
        function() self:drawScene1() end,
        function() self:drawScene2() end,
        -- function() self:drawScene3() end,
        function() self:drawSupernova1() end, function() self:drawSupernova2() end, function() self:drawSupernova3() end, function() self:drawSupernova4() end,
        function() self:drawLighthouse1() end, function() self:drawLighthouse2() end, function() self:drawLighthouse3() end, function() self:drawLighthouse4() end, function() self:drawLighthouse5() end, function() self:drawLighthouse6() end,
        -- function() self:drawRocket1() end, function() self:drawRocket2() end, function() self:drawRocket3() end, function() self:drawRocket4() end, function() self:drawRocket5() end,
        function() self:drawLeaf2() end, function() self:drawLeaf3() end, function() self:drawLeaf4() end, function() self:drawLeaf5() end, function() self:drawLeaf6() end,
        function() self:drawAstronaut1() end, function() self:drawAstronaut2() end, function() self:drawAstronaut3() end, function() self:drawAstronaut4() end, function() self:drawAstronaut5() end, function() self:drawAstronaut6() end, function() self:drawAstronaut7() end,
        function() self:drawSceneFinal() end,
        function() self:drawSceneFinal() end,
        function() self:drawSceneFinal() end,
    }
    self.sceneBgs = {
        "NA",
        "Night",
        "Night", "Night", "Night", "Night",
        "Night 2", "Starlight", "Starlight", "Starlight", "Starlight", "Starlight",
        -- "Starlight", "Starlight", "Starlight", "Starlight", "Starlight",
        "Starlight", "Starlight", "Starlight", "Starlight", "Starlight",
        "Starlight", "Starlight", "Starlight", "Starlight", "Starlight", "Starlight", "Starlight",
        "Starlight",
        "Starlight"
    }
    self.sceneTimings = {
        0,
        0,
        31, 52, 53, 54,
        55, 56, 57.5, 59, 60.5, 62,
        65, 66.5, 68, 69.5, 71,
        74, 76, 78, 80, 82, 85, 89,
        98
    }
    -- self.sceneTimings = {
    --     0,
    --     0,
    --     55, 56.1, 57.2, 58.3, 59.4, 60.5,
    --     61.7, 62.8, 63.9, 65, 66.1, 67.2,
    --     68.4, 69.5, 70.6, 71.7, 72.8,
    --     90
    -- }
    self.sceneDuration = 0
    self.currSceneIndex = 1

    self.nightAsset1 = love.graphics.newImage("Cutscene/Night.png")
    self.nightAsset2 = love.graphics.newImage("Cutscene/Night 2.png")
    self.nightX = math.min(0, love.graphics.getWidth() / 2 - self.nightAsset1:getWidth() / 2)
    self.nightY = 0

    self.starlightAsset1 = love.graphics.newImage("Cutscene/Starlight.png")
    self.starlightAsset2 = love.graphics.newImage("Cutscene/Starlight 2.png")
    self.starlightAsset3 = love.graphics.newImage("Cutscene/Starlight 3.png")
    self.starlightAssetX = self.nightX
    self.starlightAssetY = self.nightY

    self.initial1 = love.graphics.newImage("Cutscene/Initial 1.png")
    self.initial1_2 = love.graphics.newImage("Cutscene/Initial 1 2.png")
    self.initial1Frames = {self.initial1, self.initial1_2}

    self.supernova1 = love.graphics.newImage("Cutscene/Supernova 1.png")
    self.supernova1_2 = love.graphics.newImage("Cutscene/Supernova 1 2.png")
    self.supernova1Frames = {self.supernova1, self.supernova1_2}

    self.supernova2 = love.graphics.newImage("Cutscene/Supernova 2.png")
    self.supernova3 = love.graphics.newImage("Cutscene/Supernova 3.png")
    self.supernova4 = love.graphics.newImage("Cutscene/Supernova 4.png")

    self.lighthouse1 = love.graphics.newImage("Cutscene/Lighthouse 1.png")
    self.lighthouse2 = love.graphics.newImage("Cutscene/Lighthouse 2.png")
    self.lighthouse3 = love.graphics.newImage("Cutscene/Lighthouse 3.png")
    self.lighthouse4 = love.graphics.newImage("Cutscene/Lighthouse 4.png")
    self.lighthouse5 = love.graphics.newImage("Cutscene/Lighthouse 5.png")

    self.leaf1 = love.graphics.newImage("Cutscene/Leaf 1.png")
    self.leaf2 = love.graphics.newImage("Cutscene/Leaf 2.png")
    self.leaf3 = love.graphics.newImage("Cutscene/Leaf 3.png")
    self.leaf4 = love.graphics.newImage("Cutscene/Leaf 4.png")
    self.leaf5 = love.graphics.newImage("Cutscene/Leaf 5.png")

    self.rocket1 = love.graphics.newImage("Cutscene/Rocket 1.png")
    self.rocket2 = love.graphics.newImage("Cutscene/Rocket 2.png")
    self.rocket3 = love.graphics.newImage("Cutscene/Rocket 3.png")
    self.rocket4 = love.graphics.newImage("Cutscene/Rocket 4.png")

    self.astronaut1 = love.graphics.newImage("Cutscene/Astronaut 1.png")
    self.astronaut2 = love.graphics.newImage("Cutscene/Astronaut 2.png")
    self.astronaut3 = love.graphics.newImage("Cutscene/Astronaut 3.png")
    self.astronaut4 = love.graphics.newImage("Cutscene/Astronaut 4.png")
    self.astronaut5 = love.graphics.newImage("Cutscene/Astronaut 5.png")
    self.astronaut6 = love.graphics.newImage("Cutscene/Astronaut 6.png")

    self.black = love.graphics.newImage("Cutscene/Black.png")

    self.gamma = 0.5
    self.holdDuration = 1
    self.currDuration = 0
    self.songIsPlaying = false
    self.cutsceneTriggered = false
    
    self.animationIndex = 1
    self.animationIndexDuration = 2
    self.currIndexDuration = 0
end

function End:update(dt)
    if self.blackCardFadingIn then
        self.blackCardOpacity = math.min(self.blackCardOpacity + self.blackCardFadeSpeed * dt, 1)
    end

    if self.blackCardOpacity == 1 and not self.songIsPlaying then
        self.currDuration = self.currDuration + dt
        self.blackCardFadingIn = false
        if self.currDuration >= self.holdDuration then
            self.songIsPlaying = true
            SongManager:suddenlyIntoNext()

            self.fadeIntoNextScene = true
            -- self.readyToEnd = true

        end
    end

    if self.songIsPlaying then
        self.sceneDuration = self.sceneDuration + dt
        self.currIndexDuration = self.currIndexDuration + dt
    end

    if self.currIndexDuration >= self.animationIndexDuration then
        self.currIndexDuration = 0
        self.animationIndex = self.animationIndex + 1
    end

    if self.currSceneIndex >= 2 and self.currSceneIndex <= #self.sceneTimings - 1 then
        local sceneDurationThreshold = self.sceneTimings[self.currSceneIndex + 1] - self.sceneTimings[self.currSceneIndex]
        if self.sceneDuration >= sceneDurationThreshold then
            self.fadeIntoNextScene = true
            self.sceneDuration = 0
        end
    end

    if self.fadeIntoNextScene then
        self.fadeOutOpacity = math.max(self.fadeOutOpacity - self.canvasFadeSpeed * dt, 0)
        self.fadeInOpacity = math.min(self.fadeInOpacity + self.canvasFadeSpeed * dt, 1)
        if self.fadeOutOpacity == 0 and self.fadeInOpacity == 1 then
            self.fadeOutOpacity = 1
            self.fadeInOpacity = 0
            self.fadeIntoNextScene = false
            self.currSceneIndex = self.currSceneIndex + 1
            -- self.sceneDuration = 0
            self.canvasFadeSpeed = 4
            print(self.currSceneIndex)
            print(#self.sceneTimings)
            if self.currSceneIndex + 1 == #self.sceneTimings or self.currSceneIndex == #self.sceneTimings then
                self.canvasFadeSpeed = 0.12
            end

            if self.currSceneIndex == #self.sceneTimings then
                self.readyToEnd = true
            end
        end
    end
end

function End:draw()
    if self.cutsceneTriggered then
        love.graphics.setColor(0, 0, 0, self.blackCardOpacity)
        -- if self.readyToEnd then
        --     love.graphics.setColor(0, 0, 0, 1)
        -- end
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        SetColorHEX("#FFFFFF")

        love.graphics.setCanvas(self.backgroundCanvas)
        love.graphics.clear()

        local currBg = self.sceneBgs[self.currSceneIndex]
        local nextBg = self.sceneBgs[self.currSceneIndex + 1]
        if currBg == nextBg then
            self:drawBg(currBg, nextBg, 1, 0)
        else
            self:drawBg(currBg, nextBg, self.fadeOutOpacity, self.fadeInOpacity)
        end

        love.graphics.setCanvas(self.combinedCanvas)
        love.graphics.clear()

        love.graphics.setColor(1, 1, 1, self.fadeOutOpacity ^ self.gamma)
        self.sceneDraws[self.currSceneIndex]()

        if self.currSceneIndex ~= #self.sceneDraws then
            love.graphics.setColor(1, 1, 1, self.fadeInOpacity ^ self.gamma)
            self.sceneDraws[self.currSceneIndex + 1]()
        end

        self:drawCombinedCanvas()
        SetColorHEX("#FFFFFF")
    end
end

function End:drawScene1()
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
end

function End:getInitial1()
    local animationIndex = self.animationIndex % #self.initial1Frames
    if animationIndex == 0 then
        animationIndex = #self.initial1Frames
    end
    return self.initial1Frames[animationIndex]
end

function End:drawScene2()
    local initialSx = love.graphics.getWidth() / self.initial1:getWidth()
    local initialSy = love.graphics.getWidth() / self.initial1:getWidth()
    love.graphics.draw(self:getInitial1(), 0, 0, 0, initialSx, initialSy)
end

function End:drawScene3()
end

function End:getSupernova1()
    local animationIndex = self.animationIndex % #self.supernova1Frames
    if animationIndex == 0 then
        animationIndex = #self.supernova1Frames
    end
    return self.supernova1Frames[animationIndex]
end

function End:drawSupernova1()
    local supernovaSx = love.graphics.getWidth() / self.supernova1:getWidth()
    local supernovaSy = love.graphics.getWidth() / self.supernova1:getWidth()
    love.graphics.draw(self:getSupernova1(), 0, 0, 0, supernovaSx, supernovaSy)
end

function End:drawSupernova2()
    local supernovaSx = love.graphics.getWidth() / self.supernova2:getWidth()
    local supernovaSy = love.graphics.getWidth() / self.supernova2:getWidth()
    love.graphics.draw(self.supernova2, 0, 0, 0, supernovaSx, supernovaSy)
end

function End:drawSupernova3()
    local supernovaSx = love.graphics.getWidth() / self.supernova3:getWidth()
    local supernovaSy = love.graphics.getWidth() / self.supernova3:getWidth()
    love.graphics.draw(self.supernova3, 0, 0, 0, supernovaSx, supernovaSy)
end

function End:drawSupernova4()
    local supernovaSx = love.graphics.getWidth() / self.supernova4:getWidth()
    local supernovaSy = love.graphics.getWidth() / self.supernova4:getWidth()
    love.graphics.draw(self.supernova4, 0, 0, 0, supernovaSx, supernovaSy)
end

function End:drawLighthouse1()
    local lighthouseSx = love.graphics.getWidth() / self.lighthouse1:getWidth()
    local lighthouseSy = love.graphics.getWidth() / self.lighthouse1:getWidth()
    love.graphics.draw(self.lighthouse1, 0, 0, 0, lighthouseSx, lighthouseSy)
end

function End:drawLighthouse2()
    local lighthouseSx = love.graphics.getWidth() / self.lighthouse2:getWidth()
    local lighthouseSy = love.graphics.getWidth() / self.lighthouse2:getWidth()
    love.graphics.draw(self.lighthouse2, 0, 0, 0, lighthouseSx, lighthouseSy)
end

function End:drawLighthouse3()
    local lighthouseSx = love.graphics.getWidth() / self.lighthouse3:getWidth()
    local lighthouseSy = love.graphics.getWidth() / self.lighthouse3:getWidth()
    love.graphics.draw(self.lighthouse3, 0, 0, 0, lighthouseSx, lighthouseSy)
end

function End:drawLighthouse4()
    local lighthouseSx = love.graphics.getWidth() / self.lighthouse4:getWidth()
    local lighthouseSy = love.graphics.getWidth() / self.lighthouse4:getWidth()
    love.graphics.draw(self.lighthouse4, 0, 0, 0, lighthouseSx, lighthouseSy)
end

function End:drawLighthouse5()
    local lighthouseSx = love.graphics.getWidth() / self.lighthouse5:getWidth()
    local lighthouseSy = love.graphics.getWidth() / self.lighthouse5:getWidth()
    love.graphics.draw(self.lighthouse5, 0, 0, 0, lighthouseSx, lighthouseSy)
end

function End:drawLighthouse6()
end

function End:drawLeaf1()
    local leafSx = love.graphics.getWidth() / self.leaf1:getWidth()
    local leafSy = love.graphics.getWidth() / self.leaf1:getWidth()
    love.graphics.draw(self.leaf1, 0, 0, 0, leafSx, leafSy)
end

function End:drawLeaf2()
    local leafSx = love.graphics.getWidth() / self.leaf1:getWidth()
    local leafSy = love.graphics.getWidth() / self.leaf1:getWidth()
    love.graphics.draw(self.leaf2, 0, 0, 0, leafSx, leafSy)
end

function End:drawLeaf3()
    local leafSx = love.graphics.getWidth() / self.leaf1:getWidth()
    local leafSy = love.graphics.getWidth() / self.leaf1:getWidth()
    love.graphics.draw(self.leaf3, 0, 0, 0, leafSx, leafSy)
end

function End:drawLeaf4()
    local leafSx = love.graphics.getWidth() / self.leaf1:getWidth()
    local leafSy = love.graphics.getWidth() / self.leaf1:getWidth()
    love.graphics.draw(self.leaf4, 0, 0, 0, leafSx, leafSy)
end

function End:drawLeaf5()
    local leafSx = love.graphics.getWidth() / self.leaf1:getWidth()
    local leafSy = love.graphics.getWidth() / self.leaf1:getWidth()
    love.graphics.draw(self.leaf5, 0, 0, 0, leafSx, leafSy)
end

function End:drawLeaf6()
end

function End:drawRocket1()
    local rocketSx = love.graphics.getWidth() / self.rocket1:getWidth()
    local rocketSy = love.graphics.getWidth() / self.rocket1:getWidth()
    love.graphics.draw(self.rocket1, 0, 0, 0, rocketSx, rocketSy)
end

function End:drawRocket2()
    local rocketSx = love.graphics.getWidth() / self.rocket2:getWidth()
    local rocketSy = love.graphics.getWidth() / self.rocket2:getWidth()
    love.graphics.draw(self.rocket2, 0, 0, 0, rocketSx, rocketSy)
end

function End:drawRocket3()
    local rocketSx = love.graphics.getWidth() / self.rocket3:getWidth()
    local rocketSy = love.graphics.getWidth() / self.rocket3:getWidth()
    love.graphics.draw(self.rocket3, 0, 0, 0, rocketSx, rocketSy)
end

function End:drawRocket4()
    local rocketSx = love.graphics.getWidth() / self.rocket4:getWidth()
    local rocketSy = love.graphics.getWidth() / self.rocket4:getWidth()
    love.graphics.draw(self.rocket4, 0, 0, 0, rocketSx, rocketSy)
end

function End:drawRocket5()
end

function End:drawAstronaut1()
    local astronautSx = love.graphics.getWidth() / self.astronaut1:getWidth()
    local astronautSy = love.graphics.getWidth() / self.astronaut1:getWidth()
    love.graphics.draw(self.astronaut1, 0, 0, 0, astronautSx, astronautSy)
end

function End:drawAstronaut2()
    local astronautSx = love.graphics.getWidth() / self.astronaut2:getWidth()
    local astronautSy = love.graphics.getWidth() / self.astronaut2:getWidth()
    love.graphics.draw(self.astronaut2, 0, 0, 0, astronautSx, astronautSy)
end

function End:drawAstronaut3()
    local astronautSx = love.graphics.getWidth() / self.astronaut3:getWidth()
    local astronautSy = love.graphics.getWidth() / self.astronaut3:getWidth()
    love.graphics.draw(self.astronaut3, 0, 0, 0, astronautSx, astronautSy)
end

function End:drawAstronaut4()
    local astronautSx = love.graphics.getWidth() / self.astronaut4:getWidth()
    local astronautSy = love.graphics.getWidth() / self.astronaut4:getWidth()
    love.graphics.draw(self.astronaut4, 0, 0, 0, astronautSx, astronautSy)
end

function End:drawAstronaut5()
    local astronautSx = love.graphics.getWidth() / self.astronaut5:getWidth()
    local astronautSy = love.graphics.getWidth() / self.astronaut5:getWidth()
    love.graphics.draw(self.astronaut5, 0, 0, 0, astronautSx, astronautSy)
end

function End:drawAstronaut6()
    local astronautSx = love.graphics.getWidth() / self.astronaut6:getWidth()
    local astronautSy = love.graphics.getWidth() / self.astronaut6:getWidth()
    love.graphics.draw(self.astronaut6, 0, 0, 0, astronautSx, astronautSy)
end

function End:drawAstronaut7()
end

function End:drawSceneFinal()
    local blackSx = love.graphics.getWidth() / self.black:getWidth()
    local blackSy = love.graphics.getWidth() / self.black:getWidth()
    love.graphics.draw(self.black, 0, 0, 0, blackSx, blackSy)
end

function End:drawCombinedCanvas()
    -- print("------")
    -- print(self.fadeOutOpacity)
    -- print(self.fadeInOpacity)
    -- print("------")
    love.graphics.setColor(1, 1, 1)
    love.graphics.setCanvas()
    love.graphics.draw(self.backgroundCanvas, 0, 0)
    love.graphics.draw(self.combinedCanvas, 0, 0)
    SetColorHEX("#FFFFFF")
end

function End:drawBg(bg1, bg2, opacity1, opacity2)
    local nightSy = love.graphics.getHeight() / self.nightAsset1:getHeight()
    local nightSx = love.graphics.getWidth() / self.nightAsset1:getWidth()   
    local starlightSy = love.graphics.getHeight() / self.starlightAsset1:getHeight()
    local starlightSx = love.graphics.getWidth() / self.starlightAsset1:getWidth()
    local night2Sy = love.graphics.getHeight() / self.nightAsset2:getHeight()
    local night2Sx = love.graphics.getWidth() / self.nightAsset2:getWidth()   
    local starlight2Sy = love.graphics.getHeight() / self.starlightAsset2:getHeight()
    local starlight2Sx = love.graphics.getWidth() / self.starlightAsset2:getWidth()
    local starlight3Sy = love.graphics.getHeight() / self.starlightAsset3:getHeight()
    local starlight3Sx = love.graphics.getWidth() / self.starlightAsset3:getWidth()

    love.graphics.setColor(1, 1, 1, opacity1 ^ self.gamma)
    if bg1 == "Night" then
        love.graphics.draw(self.nightAsset1, 0, 0, 0, nightSx, nightSy)
    elseif bg1 == "Night 2" then
        love.graphics.draw(self.nightAsset2, 0, 0, 0, night2Sx, night2Sy)
    elseif bg1 == "Starlight" then
        love.graphics.draw(self.starlightAsset1, 0, 0, 0, starlightSx, starlightSy)
    elseif bg1 == "Starlight 2" then
        love.graphics.draw(self.starlightAsset2, 0, 0, 0, starlight2Sx, starlight2Sy)
    elseif bg1 == "Starlight 3" then
        love.graphics.draw(self.starlightAsset3, 0, 0, 0, starlight3Sx, starlight3Sy)
    end

    love.graphics.setColor(1, 1, 1, opacity2 ^ self.gamma)
    if bg2 == "Night" then
        love.graphics.draw(self.nightAsset1, 0, 0, 0, nightSx, nightSy)
    elseif bg2 == "Night 2" then
        love.graphics.draw(self.nightAsset2, 0, 0, 0, night2Sx, night2Sy)
    elseif bg2 == "Starlight" then
        love.graphics.draw(self.starlightAsset1, 0, 0, 0, starlightSx, starlightSy)
    elseif bg2 == "Starlight 2" then
        love.graphics.draw(self.starlightAsset2, 0, 0, 0, starlight2Sx, starlight2Sy)
    elseif bg2 == "Starlight 3" then
        love.graphics.draw(self.starlightAsset3, 0, 0, 0, starlight3Sx, starlight3Sy)
    end
end

function End:getNightAsset1()
    return self.nightAsset1
end

function End:trigger()
    self.cutsceneTriggered = true
    self.blackCardFadingIn = true
    Background:getDrawable("Door"):uneternallyFresh()
    Background:getDrawable("Door"):unfreshen()
end

function End:isFadingIn()
    return self.blackCardFadingIn
end

function End:isReadyToEnd()
    return self.readyToEnd
end

function End:isCutsceneTriggered()
    return self.cutsceneTriggered
end