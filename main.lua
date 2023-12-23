-- Main controller for the Colony_Manager app

local config = require("config")
local displayManager = require("ui.displayManager")

print("Colony Manager starting...")

-- Initialize home page display
displayManager.showHomePage()

-- Continuously listen for user navigation inputs
displayManager.handleNavigation() -- The loop inside this function will keep the script running
