SongManager = Object:extend()

function SongManager:load()
    self.songs = {
       [1] = love.audio.newSource("Sounds/Start 1.mp3", "stream"),

       [2] = love.audio.newSource("Sounds/Start 2.mp3", "stream"),

       [3] = love.audio.newSource("Sounds/Start 3.mp3", "stream"),

       [4] = love.audio.newSource("Sounds/Start 4.mp3", "stream"),
       [5] = love.audio.newSource("Sounds/Start 6.mp3", "stream"),
       [6] = love.audio.newSource("Sounds/Mid 4.mp3", "stream"),

       [7] = love.audio.newSource("Sounds/Start 5.mp3", "stream"),

       [8] = love.audio.newSource("Sounds/Start 6.mp3", "stream"),
       [9] = love.audio.newSource("Sounds/Cutscene.mp3", "stream")
    }

    self:resetVolumes()

    self.maxVolume = 0.5
    self.currVolume = 0
    self.fadeSpeed = self.maxVolume / 2

    self.fadingOut = false
    self.fadingIn = false

    love.audio.setVolume(self.currVolume)
    self.currIndex = 0
    self.currSong = self.songs[1]
    self.currSong:play()

    self.readyToPlay = false
end

function SongManager:update(dt)
    if self.readyToPlay then
        self.fadingIn = true
        self.currSong:play()
        self.readyToPlay = false
    end
    if self.fadingOut then
        self.currVolume = math.max(self.currVolume - self.fadeSpeed * dt, 0)
        love.audio.setVolume(self.currVolume)

        if self.currVolume == 0 then
            self.fadingOut = false
            self.currSong:stop()
            self.currIndex = self.currIndex + 1
            self.currSong = self.songs[self.currIndex]
            self.currSong:setVolume(1)
        end
    elseif self.fadingIn then
        self.currVolume = math.min(self.currVolume + self.fadeSpeed * dt, self.maxVolume)
        love.audio.setVolume(self.currVolume)

        if self.currVolume == self.maxVolume then
            self.fadingIn = false
        end
    end
end

function SongManager:fadeIntoNext()
    self.fadingOut = true
end

function SongManager:suddenlyIntoNext()
    self:resetVolumes()
    self.currSong:stop()
    self.currIndex = self.currIndex + 1
    self.currSong = self.songs[self.currIndex]
    self.currSong:setVolume(1)
    love.audio.setVolume(self.maxVolume)
    if self.currIndex == #self.songs then
        love.audio.setVolume(self.maxVolume * 2)
    end
    self.currVolume = self.maxVolume
    self.currSong:play()
end

function SongManager:resetVolumes()
    for _, song in ipairs(self.songs) do
        song:setLooping(true)
        song:setVolume(0)
    end

    self.songs[#self.songs]:setLooping(false)
end

function SongManager:makeReadyToPlay()
    self.readyToPlay = true
end

function SongManager:setIndex(index)
    self.currIndex = index
end