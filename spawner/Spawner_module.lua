local max_bat = 128000000
local Treshold_bat = .98
local min_treshold_bat = .1

print ("software control true")
local battery = peripheral.find("Ultimate Energy Cube")

while(true) do
    local energy_bat = battery.getEnergy()
    local current_bat = energy_bat / max_bat

    if (current_bat > Treshold_bat) then
        redstone.setOutput("right", true)
        print("on " .. os.date("%X"))
    elseif (current_bat < min_treshold_bat) then
        redstone.setOutput("right", false)
        print("off " .. os.date("%X"))
    end

    sleep(2)
end