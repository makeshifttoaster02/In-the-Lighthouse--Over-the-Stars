SongManager = Object:extend()

function SongManager:load()
    self.songs = {
       [1] = love.audio.newSource("Sounds/Start 1.mp3", "stream"),
       [2] = love.audio.newSource("Sounds/Start 2.mp3", "stream"),
       [3] = love.audio.newSource("Sounds/Start 3.mp3", "stream"),
       [4] = love.audio.newSource("Sounds/Start 4.mp3", "stream"),
       [5] = love.audio.newSource("Sounds/Start 5.mp3", "stream"),
       [6] = love.audio.newSource("Sounds/Start 6.mp3", "stream"),
    }

    self:resetVolumes()

    self.maxVolume = 0.05
    self.currVolume = 0
    self.fadeSpeed = self.maxVolume / 2

    self.fadingOut = false
    self.fadingIn = true

    love.audio.setVolume(self.currVolume)
    self.currSong = self.songs[1]
    self.currSong:play()
end

function SongManager:update(dt)
    if self.fadingOut then
        self.currVolume = math.max(self.currVolume - self.fadeSpeed * dt, 0)
        love.audio.setVolume(self.currVolume)

        if self.currVolume == 0 then
            self.fadingOut = false
            self.currSong:stop()
            DayManager:readyToPlay()
        end
    elseif self.fadingIn then
        self.currVolume = math.min(self.currVolume + self.fadeSpeed * dt, self.maxVolume)
        love.audio.setVolume(self.currVolume)

        if self.currVolume == self.maxVolume then
            self.fadingIn = false
        end
    end
end

function SongManager:play(day)
    self.currSong = self.songs[day]
    self:resetVolumes()
    self.currSong:setVolume(1)
    self.currSong:play()
end

function SongManager:fadeOut()
    self.fadingOut = true
end

function SongManager:fadeIn()
    self.fadingIn = true
end

function SongManager:resetVolumes()
    for _, song in ipairs(self.songs) do
        song:setLooping(true)
        song:setVolume(0)
    end
end