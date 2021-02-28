local modem = peripheral.wrap("left")
local battery = peripheral.find("Ultimate Energy Cube")
local max = 128000000
local Treshold = .98
local min_treshold = .1

local spawners = {
    false,
    false,
    false,
    false,
    false
}

modem.open(14)
modem.open(13)

local function checkEnergy()
    local energy = battery.getEnergy()
    local current = energy / max

    if (current > Treshold) then
        for i = 0, table.getn(spawners), 1 do
            if spawners[i] then
                modem.transmit(15, 14, "start spawner " .. i)
            end
        end
        print("on " .. os.date("%X"))
    elseif (current < min_treshold) then
        for i = 0, table.getn(spawners), 1 do
            modem.transmit(15, 14, "stop spawner " .. i)
        end
        print("off " .. os.date("%X"))
    end
    sleep(2)
end

local function messageRec()
    local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")
    print(message)

    if senderChannel == 13 then
        if spawners[message] == false then
            spawners[message] = true
            print("spawner" .. message .. tostring(spawners[message]))
        else
            spawners[message] = false
            print("spawner" .. tostring(spawners[message]))
            modem.transmit(15, 14, "stop spawner " .. message)
        end
    end
    return true
end

local function OnStart()
    print ("software control true")
    while(true) do
        parallel.waitForAny(checkEnergy, messageRec)
        sleep(1)
    end
end

OnStart()