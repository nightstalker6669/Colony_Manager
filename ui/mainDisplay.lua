-- UI display for the Colony_Manager app on the advanced monitor

local colonyDataModule = require("modules.colonyData")

local mainDisplay = {}

function mainDisplay.showWelcomeScreen()
    local monitor = peripheral.find("monitor")
    if not monitor then
        error("Could not find an advanced monitor.")
    end
    
    local data = colonyDataModule.fetchBasicColonyData()
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.setTextScale(0.5) -- Adjust as needed for the size of the monitor
    monitor.write("Welcome to the Colony Manager!")
    monitor.setCursorPos(1, 3)
    monitor.write("Colony ID: " .. data.colonyID)
    monitor.setCursorPos(1, 4)
    monitor.write("Colony Name: " .. data.colonyName)
    monitor.setCursorPos(1, 5)
    monitor.write("Overall Happiness: " .. data.happiness)
    monitor.setCursorPos(1, 6)
    monitor.write("Citizens: " .. data.citizenCount .. "/" .. data.citizenCapacity)
    -- Other basic info can be added here
end

return mainDisplay
