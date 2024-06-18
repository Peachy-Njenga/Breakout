--to handle the powerup
PowerUp = Class{}

--powerup initialization
function PowerUp:init(skin)
    self.width = 16
    self.height = 16

    self.dx = 0 
    self.dy = 28
    
    self.skin = skin
    -- self.inPlay = true

    self.y = 0
    self.x = math.random(1, VIRTUAL_WIDTH - 16)


end

--powerup colliding iwth the paddle
function PowerUp:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

function PowerUp:update(dt)
    --making the powerup move downward
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
    
end

function PowerUp:render()
    love.graphics.draw(gTextures['main'], gFrames['powerup'],
        self.x, self.y)
    
end