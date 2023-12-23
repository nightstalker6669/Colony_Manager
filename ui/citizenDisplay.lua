local citizenDetails = require("modules.citizenDetails")
local uiHelpers = require("ui.uiHelperFunctions")

local citizenDisplay = {}

function citizenDisplay.showCitizens(citizens, drawNavigationTabs, monitor)
    monitor.clear()
    drawNavigationTabs(monitor)
    for i, citizen in ipairs(citizens) do
        citizenDisplay.drawCitizenDetails(citizen, monitor, uiHelpers.drawButton)
        local extraDetails = citizenDetails.fetchExtraCitizenDetails(citizen.id)
        local startLine = 7 + (i - 1) * 4
        monitor.setCursorPos(1, startLine)
        monitor.write('Bed position: X=' .. extraDetails.bedPosition.x .. ' Y=' .. extraDetails.bedPosition.y .. ' Z=' .. extraDetails.bedPosition.z)
        monitor.setCursorPos(1, startLine + 1)
        monitor.write('Food Saturation: ' .. extraDetails.foodSaturation)
        monitor.setCursorPos(1, startLine + 2)
        monitor.write('Happiness: ' .. extraDetails.happiness)

        if i >= 4 then
            uiHelpers.drawButton(monitor, 2, startLine + 3, "More", "moreCitizens")
            break
        end
    end
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
    local buttonX = monitorWidth - 10
    local buttonY = monitorHeight - 2
    drawButton(monitor, buttonX, buttonY, "Next", "nextCitizen")
end

return citizenDisplay
