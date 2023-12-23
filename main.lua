-- Main controller for the Colony_Manager app

local colonyDataModule = require("modules.colonyData")
local citizenMonitor = require("modules.citizenMonitor")

print("Colony Manager starting...")

colonyDataModule.fetchBasicColonyData()

-- Start monitoring the citizen statistics
local function monitorCitizenStats()
    citizenMonitor.startMonitoring()
end

-- Run monitoring in a separate thread so it doesn't block execution
parallel.waitForAny(monitorCitizenStats)

print("Exiting Colony Manager.")
