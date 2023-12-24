-- UI display for the Colony_Manager app on the advanced monitor

local colonyDataModule = require("modules.colonyData")
local navigation = require("ui.navigation")

local mainDisplay = {}

local TAB_START_LINE = 3

function mainDisplay.showWelcomeScreen(monitor)
    local data = colonyDataModule.fetchBasicColonyData()
    if not monitor then
        error("Could not find an advanced monitor.")
    end
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.setTextScale(0.5)
    monitor.write("Welcome to the Colony Manager!")
    monitor.setCursorPos(1, TAB_START_LINE + 1) -- Leave space for the tabs
    navigation.drawTabs(monitor, TAB_START_LINE)
    local infoStartLine = TAB_START_LINE + 3 -- Additional space for separation
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
