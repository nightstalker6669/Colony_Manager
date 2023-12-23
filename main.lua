-- Main controller for the Colony_Manager app

local colonyDataModule = require("modules.colonyData")
local citizenMonitor = require("modules.citizenMonitor")
local gravesMonitor = require("modules.gravesMonitor")
local constructionMonitor = require("modules.constructionMonitor")

print("Colony Manager starting...")

colonyDataModule.fetchBasicColonyData()

-- Fetch and print basic colony data
-- The peripheral name passed here should match the actual name in the Minecraft world
-- Replace 'colonyIntegrator_1' with the correct peripheral name
-- INPUT_REQUIRED {Replace 'colonyIntegrator_1' with the actual name of your Colony Integrator peripheral}
parallel.waitForAny(monitorCitizenStats)colonyDataModule.fetchBasicColonyData('colonyIntegrator')
local function monitorCitizenStats()
    citizenMonitor.startMonitoring()
end

local function monitorGravesCount()
    gravesMonitor.startMonitoring()
end

local function monitorConstructionSitesCount()
    constructionMonitor.startMonitoring()
end

-- Run all monitoring in separate threads so they don't block each other
parallel.waitForAll(monitorCitizenStats, monitorGravesCount, monitorConstructionSitesCount)

-- Run monitoring in a separate thread so it doesn't block execution
parallel.waitForAny(monitorCitizenStats)

print("Exiting Colony Manager.")
