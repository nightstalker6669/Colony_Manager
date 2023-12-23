local citizenDetails = require("modules.citizenDetails")
local uiHelpers = require("ui.uiHelperFunctions")

local citizenDisplay = {}

function citizenDisplay.showCitizens(citizens, drawNavigationTabs, monitor)
    monitor.clear()
    drawNavigationTabs(monitor)
    citizenDisplay.drawCitizenDetails(citizens[1], monitor, uiHelpers.drawButton)
end

function citizenDisplay.drawCitizenDetails(citizen, monitor, drawButton)
    monitor.setCursorPos(1, 1)
    monitor.setTextScale(0.5)
    monitor.write('Name: ' .. citizen.name)
    monitor.setCursorPos(1, 2)
    monitor.write('Age: ' .. citizen.age)
    monitor.setCursorPos(1, 3)
    monitor.write('Job: ' .. citizen.job)
    local monitorWidth, monitorHeight = monitor.getSize()
    local buttonX = monitorWidth - 10 -- Adjust buttonX as needed
    local buttonY = monitorHeight - 2 -- Adjust buttonY as needed
    drawButton(monitor, buttonX, buttonY, "Next", "nextCitizen")
end

return citizenDisplay
