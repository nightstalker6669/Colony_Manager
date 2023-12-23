local mainDisplay = require("ui.mainDisplay")
local citizenDisplay = require("ui.citizenDisplay")
local citizenDetails = require("modules.citizenDetails")
local uiHelpers = require("ui.uiHelperFunctions")

local displayManager = {}

displayManager.init = function()
    citizenDisplay.init()
end

function displayManager.showHomePage()
    mainDisplay.showWelcomeScreen()
end

function displayManager.showCitizenDetailsPage()
    local citizens = citizenDetails.fetchAllCitizenDetails()
    citizenDisplay.showCitizens(citizens, displayManager.drawNavigationTabs)
end

function displayManager.drawNavigationTabs()
    local monitor = peripheral.find("monitor")
    if not monitor then
        error("Could not find an advanced monitor.")
    end
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write("[HOME] [CITIZENS]") -- INPUT_REQUIRED {Add the appropriate padding and dynamic looping based on the tabs to display}
end

function displayManager.handleNavigation()
    while true do
        local event, side, x, y = os.pullEvent("monitor_touch")
        local buttonId = uiHelpers.getSelectedButton(x, y)
    end
end

return displayManager
