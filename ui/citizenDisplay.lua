local citizenDetails = require("modules.citizenDetails")
local uiHelpers = require("ui.uiHelperFunctions")

local citizenDisplay = {}

-- Modify existing function to include bed position, food saturation, and happiness
function citizenDisplay.showCitizens(citizens, drawNavigationTabs, monitor)
    monitor.clear()
    drawNavigationTabs(monitor)
    local y = 2 -- set initial cursor position
    for i, citizen in ipairs(citizens) do
        y = citizenDisplay.drawCitizenDetails(citizen, monitor, y) -- Pass y coordinate to function
    end
end

function citizenDisplay.drawCitizenDetails(citizen, monitor, startY)
    local y = startY
    monitor.setCursorPos(1, y)
    monitor.setTextScale(0.5)
    monitor.write('Name: ' .. citizen.name)
    y = y + 1
    monitor.setCursorPos(1, y)
    monitor.write('Age: ' .. citizen.age)
    y = y + 1
    monitor.setCursorPos(1, y)
    monitor.write('Job: ' .. citizen.job)
    y = y + 2
    local extraDetails = citizenDetails.fetchExtraCitizenDetails(citizen.id)
    monitor.setCursorPos(1, y)
    monitor.write('Bed position: X=' .. extraDetails.bedPosition.x .. ' Y=' .. extraDetails.bedPosition.y .. ' Z=' .. extraDetails.bedPosition.z)
    y = y + 1
    monitor.setCursorPos(1, y)
    monitor.write('Food Saturation: ' .. extraDetails.foodSaturation)
    y = y + 1
    monitor.setCursorPos(1, y)
    monitor.write('Happiness: ' .. extraDetails.happiness)
    y = y + 2 -- Adding an extra line for spacing
    local monitorWidth, monitorHeight = monitor.getSize()
    local buttonX = monitorWidth - 10
    local buttonY = monitorHeight - 2
    uiHelpers.drawButton(monitor, buttonX, buttonY, "Next", "nextCitizen")

    if i >= 4 then
        uiHelpers.drawButton(monitor, 2, y, "More", "moreCitizens")
        break
    end
    return y -- Return the next line's y coordinate to continue from
end

return citizenDisplay
