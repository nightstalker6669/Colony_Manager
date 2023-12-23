-- Main controller for the Colony_Manager app

local colonyDataModule = require("modules.colonyData")
local citizenMonitor = require("modules.citizenMonitor")
local gravesMonitor = require("modules.gravesMonitor")
local constructionMonitor = require("modules.constructionMonitor")
local citizenDetails = require("modules.citizenDetails")
local citizenDisplay = require("ui.citizenDisplay")

print("Colony Manager starting...")

colonyDataModule.fetchBasicColonyData('colonyIntegrator_1')

local function monitorCitizenStats()
    citizenMonitor.startMonitoring()
end

local function monitorGravesCount()
    gravesMonitor.startMonitoring()
end

local function monitorConstructionSitesCount()
    constructionMonitor.startMonitoring()
end

local function displayCitizenDetails()
    while true do
        local details = citizenDetails.fetchAllCitizenDetails()
        citizenDisplay.drawCitizenDetails(details)
        os.sleep(config.refreshRate)
    end
end

parallel.waitForAll(monitorCitizenStats, monitorGravesCount, monitorConstructionSitesCount, displayCitizenDetails)

citizenDetails.logCitizenDetails()

print("Exiting Colony Manager.")
