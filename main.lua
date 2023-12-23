-- Main controller for the Colony_Manager app

local colonyDataModule = require("modules.colonyData")
local citizenMonitor = require("modules.citizenMonitor")
local gravesMonitor = require("modules.gravesMonitor")
local constructionMonitor = require("modules.constructionMonitor")

print("Colony Manager starting...")

-- Fetch and print basic colony data
-- The peripheral name passed here should match the actual name in the Minecraft world
-- INPUT_REQUIRED {Replace 'colonyIntegrator_1' with the correct peripheral name}
colonyDataModule.fetchBasicColonyData('colonyIntegrator_1')

-- Define the monitoring functions
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

-- For demonstration purposes, log the detailed citizen information to the console.
local citizenDetails = require("modules.citizenDetails")
citizenDetails.logCitizenDetails()

print("Exiting Colony Manager.")
