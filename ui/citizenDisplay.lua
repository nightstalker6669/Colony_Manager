-- UI functionalities for displaying citizen details on the advanced monitor

local monitor = peripheral.find("monitor")
if not monitor then
    error("Could not find an advanced monitor.")
end

local citizenDisplay = {}

function citizenDisplay.drawCitizenDetails(citizens)
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.setTextScale(0.5) -- Adjust as needed for the size of the monitor
    monitor.write("Detailed Citizen Info:")
    for i, citizen in ipairs(citizens) do
        monitor.setCursorPos(1, 2 + (i * 6)) -- Adjust spacing as needed
        monitor.write("ID: " .. citizen.id)
        monitor.setCursorPos(1, 3 + (i * 6))
        monitor.write("Name: " .. citizen.name)
        monitor.setCursorPos(1, 4 + (i * 6))
        monitor.write("Age: " .. citizen.age)
        monitor.setCursorPos(1, 5 + (i * 6))
        monitor.write("Gender: " .. citizen.gender)
        monitor.setCursorPos(1, 6 + (i * 6))
        monitor.write("Location: X=" .. citizen.location.x .. " Y=" ..
                      citizen.location.y .. " Z=" .. citizen.location.z)
    end
end

return citizenDisplay
