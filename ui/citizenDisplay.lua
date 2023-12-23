local citizenDetails = require("modules.citizenDetails")
local monitor = peripheral.find("monitor")
local uiHelpers = require("ui.uiHelperFunctions")
local currentCitizenIndex = 1

if not monitor then
    error("Could not find an advanced monitor.")
end

local citizenDisplay = {}

function citizenDisplay.cycleCitizenDetails(citizens)
    currentCitizenIndex = currentCitizenIndex + 1
    if currentCitizenIndex > #citizens then
        currentCitizenIndex = 1
    end
    citizenDisplay.drawCitizenDetails(citizens[currentCitizenIndex])
end

function citizenDisplay.drawCitizenDetails(citizen)
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.setTextScale(0.5) 
    monitor.write("Detailed Citizen Info:")
    monitor.setCursorPos(1, 3)
    monitor.write("ID: " .. citizen.id)
    monitor.setCursorPos(1, 4)
    monitor.write("Name: " .. citizen.name)
    monitor.setCursorPos(1, 5)
    monitor.write("Age: " .. citizen.age)
    monitor.setCursorPos(1, 6)
    monitor.write("Gender: " .. citizen.gender)
    monitor.setCursorPos(1, 7)
    monitor.write("Location: X=" .. citizen.location.x .. " Y=" ..
                  citizen.location.y .. " Z=" .. citizen.location.z)
    local extraDetails = citizenDetails.fetchExtraCitizenDetails(citizen.id)
    monitor.setCursorPos(1, 8)
    monitor.write("Bed Position: X=" .. extraDetails.bedPosition.x ..
                  " Y=" .. extraDetails.bedPosition.y ..
                  " Z=" .. extraDetails.bedPosition.z)
    monitor.setCursorPos(1, 9)
    monitor.write("Food Saturation: " .. extraDetails.foodSaturation)
    monitor.setCursorPos(1, 10)
    monitor.write("Happiness: " .. extraDetails.happiness)
    
    uiHelpers.drawButton(monitorXMax - 10, monitorYMax - 2, "Next Citizen", "nextCitizen") 
end

return citizenDisplay
