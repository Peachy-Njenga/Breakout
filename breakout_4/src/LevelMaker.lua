LevelMaker = Class{}

function LevelMaker.createMap( level)
    local bricks = {}

    --choose random number of rows
    local numRows = math.random(1, 5)

    --randomly choose column number
    local numCols = math.random(7, 13)

    --brick layout
    for y = 1, numRows do
        for x=1, numCols do
            b = Brick(
                --x-coordinate
                (x-1) --tables are one indexed while coordinates are 0 
                * 32  --brick width
                + 8    --screen has 8 px of padding
                + (13 - numCols) * 16,

                --y-coordinte
                y * 16
            )
            table.insert(bricks, b)
        end
    end

    return bricks
end

