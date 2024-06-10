-- Start state Class


--inherits all the the methods of BaseState
StartState = Class { __includes = BaseState }

--for selecting the "Start" or "High Scores" options on the menu
local highlighted = 1

function StartState:update(dt)
    --toggle options when arrow up or down is pressed
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
        gSounds['paddle-hit']:play()
    end

    --close the application is escape is pressed at this point
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StartState:render()
    --display the title of the game
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    --instructions
    love.graphics.setFont(gFonts['medium'])

    --if 1 is highligheted, render it blue
    if highlighted == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, 'center')

    --reset the Color
    love.graphics.setColor(1, 1, 1, 1)

    --render option 2 blue if it's highligheted
    if highlighted == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 90,
        VIRTUAL_WIDTH, 'center')

    --reset to white
    love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 90,
        VIRTUAL_WIDTH, 'center')
end
