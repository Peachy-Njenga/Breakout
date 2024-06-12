--global patterns to make the map a certain shape
NONE = 1
SINGLE_PYRAMID = 2
MULTI_PYRAMID = 3

--patterns per rows
SOLID = 1       --all colours the same
ALTERNATE = 2   --alternate colors
SKIP = 3        --skip every block 

LevelMaker = Class{}

--[[
    Creates a table of Bricks to be returned to the main game, with different
    possible ways of randomizing rows and columns of bricks. Calculates the
    brick colors and tiers to choose based on the level passed in.
]] --revisit

function LevelMaker.createMap(level)
    local bricks = {}

    --choose random number of rows
    local numRows = math.random(1, 5)

    --randomly choose column number - ensure they're odd to prevent asymmetry
    local numCols = math.random(7, 13)
    numCols = numCols % 2 == 0 and (numCols + 1) or numCols

    --highest spawned brick color in each leve, max should be 3
    local highestTier = math.min(3, math.floor(level /5))

    --highest colour of the highest tiers
    local highestColor = math.min(5, level % 5 + 3)

    --brick layout to fill the space ad touch 
    for y = 1, numRows do
        --will there be skipping this row? If 1, then we'll skip
        local skipPattern = math.random(1,2) == 1 and true or false

        --alternating colours for this row?
        local alternatePattern = math.random(1, 2) == 1 and true or false

        --choose the two colors to alternate between 
        local alternateColor1 = math.random( 1, highestColor)
        local alternateColor2 = math.random( 1, highestColor)
        local alternateTier1 = math.random(0, highestTier)
        local alternateTier2 = math.random(0, highestTier)

        -- when we want to skip a block 
        local skipFlag = math.random(2) == 1 and true or false

        --alternating a block for alternating a pattern 
        local alternateFlag = math.random(2) == 1 and true or false

        --solid colour used when not alternating 
        local solidColor = math.random( 1, highestColor )
        local solidTier = math.random( 1, highestTier )



        for x=1, numCols do
            --if skip is on, and we're on  a skip iteration
            if skipPattern and skipFlag then
                --turn skip off for th next
                skipFlag = not skipFlag
                --continue statement work around for Lua 
                goto continue
            else
                --flip it to true when we're not using it 
                skipFlag = not skipFlag
            end

            

            b = Brick(
                --x-coordinate
                (x-1) --tables are one indexed while coordinates are 0 
                * 32  --brick width
                + 8    --screen has 8 px of padding
                + (13 - numCols) * 16,

                --y-coordinte
                y * 16
            )

            --if alternating, which colour or tier are we on?
            if alternatePattern and alternateFlag then
                b.color = alternateColor1
                b.tier = alternateTier1
                alternateFlag = not alternateFlag
            else
                b.color = alternateColor2
                b.tier = alternateTier2
                alternateFlag = not alternateFlag
            end

            --if we're not alternating.
            if not alternatePattern then
                b.color = solidColor
                b.tier = solidTier
            end

            table.insert(bricks, b)

            --Lua's verison of continues
            ::continue::
        end
    end

    --if we didn't generate any bricks
    if #bricks ==0 then
        return self.createMap(level)
    else
        return bricks
    end
end

