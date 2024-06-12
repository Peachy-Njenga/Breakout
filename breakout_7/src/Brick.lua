Brick = Class {}

function Brick:init(x, y)
    self.tier = 0
    self.color = 1

    self.x = x
    self.y = y
    self.width = 32
    self.height = 16

    --should brick be rendered
    self.inPlay = true
end

--[[
    Triggers when brck is hit
]]

function Brick:hit()
    --sounds
    gSounds['brick-hit-2']:stop()
    gSounds['brick-hit-2']:play()

    -- if at a higher tier than th ebase, go down a tier
    -- if at the lowest colour, else, just go down a color 
    if self.tier > 0 then
        if self.color == 1 then
            self.tier = self.tier - 1
            self.color = 5
        else
            self.color = self.color -1 
        end
    else
        --if in first tier but base colour:- remove brick from play 
        if self.color == 1 then
            self.inPlay = false
        else
            self.color = self.color - 1
        end
    end

    --play second layer of sound if brick is destroyed
    if not self.inPlay then
        gSounds['brick-hit-1']:stop()
        gSounds['brick-hit-1']: play()
    end

end

function Brick:render()
    if self.inPlay then
        love.graphics.draw(gTextures['main'],
            gFrames['bricks'][1 + ((self.color - 1) * 4) + self.tier],
            self.x, self.y)
    end
end