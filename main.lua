-- Main controller for the Colony_Manager app

-- Import the displayManager module
local displayManager = require("ui.displayManager")

print("Colony Manager starting...")

displayManager.init()

displayManager.handleNavigation() -- The loop inside this function will keep the script running
