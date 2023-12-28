-- UI display for the Colony_Manager app on the advanced monitor

local colonyDataModule = require("modules.colonyData")
local navigation = require("ui.navigation")

local mainDisplay = {}

local TAB_START_LINE = 3

function mainDisplay.showWelcomeScreen(monitor)
    -- If the monitor isn't passed in, look for it
    if not monitor then
        monitor = peripheral.find("monitor")
        if not monitor then
            error("Could not find an advanced monitor.")
        end
    end
    local data
    -- Protected call (pcall) to catch exceptions from data fetching
    local success, message = pcall(function()
      data = colonyDataModule.fetchBasicColonyData()
    end)

    -- If data fetching failed, show error and return
    if not success then
        monitor.clear()
        monitor.setTextScale(0.5)
        monitor.setCursorPos(1,1)
        monitor.write("Error fetching colony data:")
        monitor.setCursorPos(1,2)
        monitor.write(message)
        return
    end
    monitor.clear()
    monitor.setTextScale(0.5)
    monitor.setCursorPos(1,1)
    monitor.write("Welcome to the Colony Manager!")
    monitor.setCursorPos(1, TAB_START_LINE + 1) -- Leave space for the tabs
    navigation.drawTabs(monitor, TAB_START_LINE)
    local infoStartLine = TAB_START_LINE + 4 -- Leave enough space for the tabs and the aesthetics
    monitor.setCursorPos(1, infoStartLine)
    monitor.write("Colony ID: " .. data.colonyID)
    monitor.setCursorPos(1, infoStartLine + 1)
    monitor.write("Colony Name: " .. data.colonyName)
    monitor.setCursorPos(1, infoStartLine + 2)
    monitor.write("Overall Happiness: " .. data.happiness)
    monitor.setCursorPos(1, infoStartLine + 3)
    monitor.write("Citizens: " .. data.citizenCount .. "/" .. data.citizenCapacity)
    -- Other basic info can be added here
end

return mainDisplay
