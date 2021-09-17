function placeSapling()--places sapling on postion, moving forward one block
    turtle.up()
    turtle.select(2)
    turtle.placeDown()
    turtle.forward()
    turtle.down()
end

if turtle.getFuelLevel() < 100 then --if doesn't have the fuel to complete harvest
--pulls fuel from chest above and refuels itself
    turtle.select(1)
    turtle.suckUp()
    turtle.refuel(8)
    turtle.dropUp()
end

if turtle.getFuelLevel() == 0 then return end
local counter = 0 --counter for turning
while (counter < 4) do --goes until it turns four times, back at start point
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
            placeSapling() --places sapling to regrow tree
        else --if not a log block, increment counter and turn
            counter = counter + 1
            turtle.turnLeft()
        end
    else --no block in front, just pick up blocks and move forward
        turtle.suck()
        turtle.forward()
    end
end
--cycles through all slots (besides saplings) and drops them in chest below
for i = 1,16 do
    if not (i == 2) then
        turtle.select(i)
        turtle.dropDown()
    end
end