local BUFFER_MAX = 10000000 + 12800000
local MIN_THRESHOLD = .2
local MAX_THRESHOLD = .8
local CRIT_TRESHOLD = .1

local battery = peripheral.find("Elite Energy Cube")
local reactor = peripheral.wrap("back")


while true do
local input = redstone.getInput("right")
    if input then
        print("Software Control is On...")
    end

    while(input == true) do
        
        local energy_rea = reactor.getEnergyStored()
        local energy_bat = battery.getEnergy()
        local energy_tot = energy_rea + energy_bat
        local current_med = energy_tot / BUFFER_MAX

        if (current_med < MIN_THRESHOLD) then
            reactor.setActive(true)
        elseif(current_med > MAX_THRESHOLD) then
            reactor.setActive(false)
        end


        if (current_med == 0) then
            reactor.setAllControlRodLevels(0)
            print("crit power reached ")
            sleep(5)
            reactor.setAllControlRodLevels(80)
            print("proceed as normal " .. os.date("%X"))
        elseif(current_med < CRIT_TRESHOLD) then
            reactor.setAllControlRodLevels(30)
        print("boosting")
            sleep(5)
            reactor.setAllControlRodLevels(80)
            print("proceed as normal " .. os.date("%X"))
        end

        
        sleep(2)
    end
    sleep(20)
end