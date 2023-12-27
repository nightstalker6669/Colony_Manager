-- Navigation management for the advanced monitor interface

local uiHelpers = require("ui.uiHelperFunctions")

local navigation = {}

local tabs
local actionBindings = {}

function navigation.init(monitor, actions)
    tabs = {
        { ["title"] = "HOME", ["action"] = actions.showHomePage },
        { ["title"] = "CITIZENS", ["action"] = actions.showCitizenDetailsPage }
    }
    actionBindings = actions
    navigation.drawTabs(monitor)
end

navigation.drawTabs = function(monitor)
    local startLine = _G.TAB_START_LINE -- Use the globally defined TAB_START_LINE
    monitor.clear()
    local x = 1
    for _, tab in ipairs(tabs) do
        uiHelpers.drawButton(monitor, x, startLine, tab["title"], tab["title"])
        x = x + string.len(tab["title"]) + 3
        local monitorWidth, _ = monitor.getSize()
        if x >= monitorWidth then
            x = 1
            startLine = startLine + 1
        end
    end
end

navigation.handleTabTouch = function(monitor, x, y)
    uiHelpers.validateButtonCoordinates(x, y)
    local buttonId = uiHelpers.getSelectedButton(x, y)
    if buttonId then
        local debugLogger = require("utils.debugLogger")
        debugLogger.log("Tab touch detected: " .. buttonId)
        if actionBindings[buttonId:upper()] then
            debugLogger.log("Executing action for: " .. buttonId)
            actionBindings[buttonId:upper()](monitor)
        else
            debugLogger.log("No action binding found for: " .. buttonId)
        end
    end
end

navigation.bindActions = function(bindings)
    for tabTitle, action in pairs(bindings) do
        actionBindings[tabTitle:upper()] = action
    end
end

return navigation
