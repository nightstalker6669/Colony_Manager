-- Module for monitoring real-time construction sites count
local config = require("config")
local constructionData = {}

local constructionMonitor = {}

-- Function to fetch construction sites count
local function fetchConstructionSitesCount()
    local integrator = peripheral.find("colonyIntegrator")
    if not integrator then
        error("Could not find a colonyIntegrator peripheral. Is it correctly attached to the computer?")
    end

    constructionData.count = integrator.amountOfConstructionSites()
end

-- Function to get the cached construction sites count
function constructionMonitor.getConstructionSitesCount()
    return constructionData.count
end

-- Initialize the module
local function init()
    fetchConstructionSitesCount()
end

-- This function is responsible for refreshing the data at the configured interval
function constructionMonitor.startMonitoring()
    init()

    while true do
        fetchConstructionSitesCount()
        os.sleep(config.refreshRate)
    end
end

return constructionMonitor
