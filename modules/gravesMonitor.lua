-- Module for monitoring real-time graves count
local config = require("config")
local gravesData = {}

local gravesMonitor = {}

-- Function to fetch graves count
local function fetchGravesCount()
    local integrator = peripheral.find("colonyIntegrator")
    if not integrator then
        error("Could not find a colonyIntegrator peripheral. Is it correctly attached to the computer?")
    end

    gravesData.count = integrator.amountOfGraves()
end

-- Function to get the cached graves count
function gravesMonitor.getGravesCount()
    return gravesData.count
end

-- Initialize the module
local function init()
    fetchGravesCount()
end

-- This function is responsible for refreshing the data at the configured interval
function gravesMonitor.startMonitoring()
    init()

    while true do
        fetchGravesCount()
        os.sleep(config.refreshRate)
    end
end

return gravesMonitor
