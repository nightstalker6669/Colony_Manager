-- Main controller for the Colony_Manager app

local config = require("config")
local displayManager = require("ui.displayManager")

print("Colony Manager starting...")

-- Initialize home page display
displayManager.showHomePage()

-- Listen for user navigation inputs (TO IMPLEMENT: define handleNavigation with user input detection)
displayManager.handleNavigation()

print("Exiting Colony Manager.")
