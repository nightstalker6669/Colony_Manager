-- Main display manager for the Colony_Manager app
 
local mainDisplay = require("ui.mainDisplay")
local citizenDisplay = require("ui.citizenDisplay")
local citizenDetails = require("modules.citizenDetails")
local uiHelpers = require("ui.uiHelperFunctions")
local navigation = require("ui.navigation")
local pageControls = require("ui.pageControls")

local displayManager = {}

local currentPage = 0

_G.TAB_START_LINE = 3

function displayManager.showCitizenDetailsPage(monitor, currentPage)
    local citizens = citizenDetails.fetchAllCitizenDetails()
    currentPage = math.max(0, math.min(math.ceil(#citizens / 4) - 1, currentPage))
    citizenDisplay.showCitizens(citizens, monitor, currentPage)
    local _, monitorHeight = monitor.getSize()
    local totalPages = math.ceil(#citizens / 4)
    local yCoordinateForPageControls = monitorHeight - 1
    pageControls.showPageControls(monitor, currentPage, totalPages, yCoordinateForPageControls)
end
displayManager.showHomePage = function(monitor)
    mainDisplay.showWelcomeScreen(monitor)
end

function displayManager.init()
    local monitor = peripheral.find("monitor")
    if not monitor then
        error("Could not find an advanced monitor.")
    end
    navigation.init(monitor, {
        showHomePage = function() displayManager.showHomePage(monitor) end,
        showCitizenDetailsPage = function() displayManager.showCitizenDetailsPage(monitor, currentPage) end
    })
    
navigation.bindActions({
        HOME = function() displayManager.showHomePage(monitor) end,
        CITIZENS = function() displayManager.showCitizenDetailsPage(monitor, currentPage) end,
        nextPage = function() pageControls.changePage(monitor, 1, displayManager.showCitizenDetailsPage) end,
        prevPage = function() pageControls.changePage(monitor, -1, displayManager.showCitizenDetailsPage) end
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
