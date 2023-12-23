-- Main display manager for the Colony_Manager app

local mainDisplay = require("ui.mainDisplay")
local citizenDisplay = require("ui.citizenDisplay")
local citizenDetails = require("modules.citizenDetails")
local uiHelpers = require("ui.uiHelperFunctions")
local navigation = require("ui.navigation")

local displayManager = {}

-- Function that shows citizen details
function displayManager.showCitizenDetailsPage(monitor)
    local citizens = citizenDetails.fetchAllCitizenDetails()
    citizenDisplay.showCitizens(citizens, monitor)
end

-- Function to show the home page
displayManager.showHomePage = function(monitor)
    mainDisplay.showWelcomeScreen(monitor)
    navigation.init(monitor, {
        showHomePage = displayManager.showHomePage,
        showCitizenDetailsPage = displayManager.showCitizenDetailsPage
    })
end

displayManager.init = function()
    local monitor = peripheral.find("monitor")
    if not monitor then
        error("Could not find an advanced monitor.")
    end
    
    navigation.init(monitor, {
        showHomePage = displayManager.showHomePage,
        showCitizenDetailsPage = displayManager.showCitizenDetailsPage
    })
    navigation.bindActions({
        HOME = function() displayManager.showHomePage(monitor) end,
        CITIZENS = function() displayManager.showCitizenDetailsPage(monitor) end
    })
    
    displayManager.showHomePage(monitor) -- Display the home page by default
end

function displayManager.handleNavigation()
    local monitor = peripheral.find("monitor")
    if not monitor then
        error("Could not find an advanced monitor.")
    end
    displayManager.init(monitor)
    while true do
        local event, side, x, y = os.pullEvent("monitor_touch")
        navigation.handleTabTouch(monitor, x, y)
    end
end

return displayManager
