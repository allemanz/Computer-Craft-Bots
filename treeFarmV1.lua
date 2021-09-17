--select fuel in first slot and refuels itself
turtle.select(1)
turtle.refuel()
local counter = 0 --counter for turning around
while (counter < 2) do --goes until it turns around twice, back at start point
    if turtle.detect() then --if block in front
        local success,data = turtle.inspect()
        if not (string.find(data.name,"log") == nil) then --check for log block
            --digs first block and moves under tree
            turtle.dig()
            turtle.forward()
            --now digs up until no blocks above it
            while turtle.detectUp() do
                turtle.digUp()
                turtle.suckUp()
                turtle.up()
            end
            --moves back down to the ground after
            while not turtle.detectDown() do
                turtle.down()
            end
        else --if not a log block, increment counter and turn around
            counter += 1
            turtle.turnLeft()
            turtle.turnLeft()
        end
    else --no block in front, just pick up blocks and move forward
        turtle.suck()
        turtle.forward()
    end
end
--cycles through all slots and drops them in chest below
for i = 1,16 do
    turtle.select(i)
    turtle.dropDown()
end