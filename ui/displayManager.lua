local mainDisplay = require("ui.mainDisplay")
local citizenDisplay = require("ui.citizenDisplay")
local citizenDetails = require("modules.citizenDetails")
local uiHelpers = require("ui.uiHelperFunctions")
local displayManager = {}

function displayManager.showHomePage()
    mainDisplay.showWelcomeScreen()
end

function displayManager.showCitizenDetailsPage()
    local citizens = citizenDetails.fetchAllCitizenDetails()
    citizenDisplay.drawCitizenDetails(citizens[currentCitizenIndex])
end

function displayManager.handleNavigation()
    local event, side, x, y = os.pullEvent("monitor_touch")
    local monitorYMax = 20 
    if y == 1 then
        displayManager.showHomePage()
    elseif y >= 3 and y <= 5 then
        displayManager.showCitizenDetailsPage()
    elseif y == monitorYMax - 2 and x >= monitorXMax - 10 and x <= monitorXMax then 
        citizenDisplay.cycleCitizenDetails(citizenDetails.fetchAllCitizenDetails())
    end
end

return displayManager
