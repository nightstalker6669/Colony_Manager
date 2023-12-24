local citizenDetails = require("modules.citizenDetails")
local uiHelpers = require("ui.uiHelperFunctions")

local citizenDisplay = {}

local currentPage = 0 -- New variable for pagination

function citizenDisplay.showCitizens(citizens, monitor)
    local y = 2
    local citizensPerPage = 4
    local startIndex = currentPage * citizensPerPage + 1
    local endIndex = math.min(startIndex + citizensPerPage - 1, #citizens)

    for i = startIndex, endIndex do
        local citizen = citizens[i]
        y = citizenDisplay.drawCitizenDetails(citizen, monitor, y)
    end

    if endIndex < #citizens then
        local monitorWidth, monitorHeight = monitor.getSize()
        local buttonX = monitorWidth - 10
        local buttonY = monitorHeight - 2
        uiHelpers.drawButton(monitor, buttonX, buttonY, "Next", "nextCitizen")
    end
end

function citizenDisplay.incrementPage()
    currentPage = currentPage + 1
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
    monitor.write('Job: ' .. (citizen.job or "N/A"))
    y = y + 1
    monitor.setCursorPos(1, y)
    monitor.write('location: X=' .. citizen.location.x .. ' Y=' .. citizen.location.y .. ' Z=' .. citizen.location.z)
    y = y + 1
    monitor.setCursorPos(1, y)
    monitor.write('Food Saturation: ' .. citizen.foodSaturation)
    y = y + 1
    monitor.setCursorPos(1, y)
    monitor.write('Happiness: ' .. citizen.happiness)
    y = y + 2 -- Adding an extra line for spacing

    return y -- Return the next line's y coordinate to continue from
end

return citizenDisplay
