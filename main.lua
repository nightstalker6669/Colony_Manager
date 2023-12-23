-- Main controller for the Colony_Manager app

local colonyDataModule = require("modules.colonyData")

print("Colony Manager starting...")

-- Fetch and print basic colony data
colonyDataModule.fetchBasicColonyData()

print("Exiting Colony Manager.")
