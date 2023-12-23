local uiHelpers = require("ui.uiHelperFunctions")
local displayManager = require("ui.displayManager")

local navigation = {}

local tabs = {
    { title = "HOME", action = displayManager.showHomePage },
    { title = "CITIZENS", action = displayManager.showCitizenDetailsPage },
    -- Add more tabs as needed
}

function navigation.init()
    local monitor = peripheral.find("monitor")
    if not monitor then
        error("Could not find an advanced monitor.")
    end
    local w, _ = monitor.getSize()
    local x = 1
    for _, tab in ipairs(tabs) do
        uiHelpers.drawButton(monitor, x, 1, tab.title, tab.title)
        x = x + string.len(tab.title) + 3 -- 3 spaces padding between tabs
    end
end

function navigation.handleTabTouch(x, y)
    for _, tab in ipairs(tabs) do
        local buttonId = uiHelpers.getSelectedButton(x, y, tab.title)
        if buttonId then
            tab.action()
            break
        end
    end
end

return navigation
