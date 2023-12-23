-- Main controller for the Colony_Manager app

local colonyDataModule = require("modules.colonyData")

print("Colony Manager starting...")

-- Fetch and print basic colony data
-- The peripheral name passed here should match the actual name in the Minecraft world
-- Replace 'colonyIntegrator_1' with the correct peripheral name
-- INPUT_REQUIRED {Replace 'colonyIntegrator_1' with the actual name of your Colony Integrator peripheral}
colonyDataModule.fetchBasicColonyData('colonyIntegrator_1')

print("Exiting Colony Manager.")
