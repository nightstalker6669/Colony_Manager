-- Main display manager for the Colony_Manager app

local mainDisplay = require("ui.mainDisplay")
local citizenDisplay = require("ui.citizenDisplay")
local citizenDetails = require("modules.citizenDetails")
local uiHelpers = require("ui.uiHelperFunctions")
local navigation = require("ui.navigation")

local displayManager = {}

local function showNextPage(monitor)
    citizenDisplay.incrementPage()
    displayManager.showCitizenDetailsPage(monitor)
end

-- Function that shows citizen details
function displayManager.showCitizenDetailsPage(monitor)
    local citizens = citizenDetails.fetchAllCitizenDetails()
    citizenDisplay.showCitizens(citizens, monitor)
end

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

    navigation.drawTabs(monitor, TAB_START_LINE)

    navigation.bindActions({
        HOME = function() displayManager.showHomePage(monitor) end,
        CITIZENS = function() displayManager.showCitizenDetailsPage(monitor) end,
        nextCitizen = function() showNextPage(monitor) end
    })

    displayManager.showHomePage(monitor)
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
