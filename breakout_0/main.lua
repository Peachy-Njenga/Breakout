-- require all the dependencies
require 'Breakout-Peach.breakout_22.src.Dependencies'


function love.load()
    --nearest neighbor filter, to enable pixelation
    love.graphics.setDefaultFilter('nearest', 'nearest')

    --seed RNG so that call sto random are always random
    math.randomseed(os.time())

    --App title
    love.window.setTitle('Breakout')

    --initilize fonts
    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    }

    love.graphics.setFont(gFonts['small'])

    --load up graphics we'll use
    gTextures = {
        ['background'] = love.graphics.newImage('graphics/background.png'),
        ['main'] = love.graphics.newImage('graphics/breakout.png'),
        ['arrows'] = love.graphics.newImage('graphics/arrows.png'),
        ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
        ['particle'] = love.graphics.newImage('graphics/particle.png')
    }

    --initialize actual window
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    --set up sound effects: we can rfeer to sounds by indexing this table
    gSounds = {
        ['paddle-hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall-hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
        ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
        ['no-select'] = love.audio.newSource('sounds/no-select.wav', 'static'),
        ['brick-hit-1'] = love.audio.newSource('sounds/brick-hit-1.wav', 'static'),
        ['brick-hit-2'] = love.audio.newSource('sounds/brick-hit-2.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
        ['recover'] = love.audio.newSource('sounds/recover.wav', 'static'),
        ['high-score'] = love.audio.newSource('sounds/high_score.wav', 'static'),
        ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),

        ['music'] = love.audio.newSource('sounds/music.wav', 'static')

    }

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end
    }
    gStateMachine:change('start')

    -- table to keep track of the key that was pressed in a frame
    love.keyboard.keysPressed = {}
end

-- called whenever we resize our window dimensions
function love.resize(w, h)
    push:resize(w, h)
end

-- update function
function love.update(dt)
    -- pass in dt to the state object we're in
    gStateMachine:update(dt)

    --reset keys pressed
    love.keyboard.keysPressed = {}
end

--process keysctrokes as the happen, just once.
function love.keypressed(key)
    --add to the table of pressed keys
    love.keyboard.keysPressed[key] = true
end

--custom function to test of keystroked outside the deault love.keypressed callback.
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

--drawing objects to the setupScreen
function love.draw()
    --begin drawing with push for VR
    push:apply('start')

    --background is the same in ech state
    local backgroundWidth = gTextures['background']:getWidth()
    local backgroundHeight = gTextures['background']:getHeight()

    love.graphics.draw(gTextures['background'],
    -- draw as 0, 0 for x, y
    0, 0,
    --no rotation
    0,
    --sclae factor on x and y axis to fit screen
    VIRTUAL_WIDTH / (backgroundWidth - 1), VIRTUAL_HEIGHT / (backgroundHeight - 1)
    )

    gStateMachine:render()

    -- displayFPS()

    push:apply('end')
end
