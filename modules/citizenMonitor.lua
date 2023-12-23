-- Module for monitoring real-time citizen statistics
local config = require("config")
local colonyData = {}

local citizenMonitor = {}

-- Function to fetch citizen count and capacity
local function fetchCitizenStats()
    local integrator = peripheral.find("colonyIntegrator")
    if not integrator then
        error("Could not find a colonyIntegrator peripheral. Is it correctly attached to the computer?")
    end

    colonyData.citizenCount = integrator.amountOfCitizens()
    colonyData.citizenCapacity = integrator.maxOfCitizens()
end

-- Function to get the cached citizen count and capacity
function citizenMonitor.getCitizenStats()
    return colonyData.citizenCount, colonyData.citizenCapacity
end

-- Initialize the module
local function init()
    fetchCitizenStats()
end

-- This function is responsible for refreshing the data at the configured interval
function citizenMonitor.startMonitoring()
    init()

    while true do
        fetchCitizenStats()
        os.sleep(config.refreshRate)
    end
end

return citizenMonitor
