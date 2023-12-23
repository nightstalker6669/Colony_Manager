local mainDisplay = require("ui.mainDisplay")
local citizenDisplay = require("ui.citizenDisplay")
local citizenDetails = require("modules.citizenDetails")
local uiHelpers = require("ui.uiHelperFunctions")
local navigation = require("ui.navigation")

local displayManager = {}

displayManager.init = function(monitor)
    navigation.init(monitor, {
        showHomePage = displayManager.showHomePage,
        showCitizenDetailsPage = displayManager.showCitizenDetailsPage
    })
end

function displayManager.showHomePage(monitor)
    mainDisplay.showWelcomeScreen(monitor)
    navigation.init(monitor)
end

function displayManager.handleNavigation()
    local monitor = peripheral.find("monitor")
    if not monitor then
        error("Could not find an advanced monitor.")
    end
    displayManager.init(monitor)  // Pass the monitor to the navigation init function 
    while true do
        local event, side, x, y = os.pullEvent("monitor_touch")
        navigation.handleTabTouch(monitor, x, y) // Pass the monitor to the handleTabTouch function
    end
end

return displayManager
