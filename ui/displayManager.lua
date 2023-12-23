local mainDisplay = require("ui.mainDisplay")
local citizenDisplay = require("ui.citizenDisplay")
local citizenDetails = require("modules.citizenDetails")
local uiHelpers = require("ui.uiHelperFunctions")
local navigation = require("ui.navigation")

local displayManager = {}

displayManager.init = function()
    citizenDisplay.init()
    navigation.init()
end

function displayManager.showHomePage()
    mainDisplay.showWelcomeScreen()
    navigation.init()
end

function displayManager.showCitizenDetailsPage()
    local citizens = citizenDetails.fetchAllCitizenDetails()
    citizenDisplay.showCitizens(citizens, navigation.init)
end

function displayManager.handleNavigation()
    while true do
        local event, side, x, y = os.pullEvent("monitor_touch")
        navigation.handleTabTouch(x, y)
    end
end

return displayManager
