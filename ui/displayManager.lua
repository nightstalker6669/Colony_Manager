-- Main display manager for the Colony_Manager app

local mainDisplay = require("ui.mainDisplay")
local citizenDisplay = require("ui.citizenDisplay")
local citizenDetails = require("modules.citizenDetails")
local uiHelpers = require("ui.uiHelperFunctions")
local navigation = require("ui.navigation")

local displayManager = {}

local currentPage = 0

local function changePage(monitor, increment)
    currentPage = currentPage + increment
    displayManager.showCitizenDetailsPage(monitor, currentPage)
end

function displayManager.showCitizenDetailsPage(monitor, currentPage)
    local citizens = citizenDetails.fetchAllCitizenDetails()
    currentPage = math.max(0, math.min(math.ceil(#citizens / 4) - 1, currentPage))
    citizenDisplay.showCitizens(citizens, monitor, currentPage)
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
        CITIZENS = function() displayManager.showCitizenDetailsPage(monitor, currentPage) end,
        nextPage = function() changePage(monitor, 1) end,
        prevPage = function() changePage(monitor, -1) end
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
