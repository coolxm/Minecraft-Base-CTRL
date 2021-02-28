local modem = peripheral.wrap("left")

modem.open(15)

while(true) do

    local event, modemSide, senderchannel, replychannel, message, senderDistance = os.pullEvent("modem_message")

    print("received message " .. message)
    if message == "start spawner 1" then
        redstone.setOutput("back",true)
    elseif message == "stop spawner 1" then
        redstone.setOutput("back", false)
    end

end