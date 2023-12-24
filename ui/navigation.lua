-- Navigation management for the advanced monitor interface

local uiHelpers = require("ui.uiHelperFunctions")

local navigation = {}

local tabs
local actionBindings

local TAB_START_LINE = 1 -- INPUT_REQUIRED Define TAB_START_LINE if not already defined elsewhere

function navigation.init(monitor, actions)
    tabs = {
        { ["title"] = "HOME", ["action"] = actions.showHomePage },
        { ["title"] = "CITIZENS", ["action"] = actions.showCitizenDetailsPage }
    }
    actionBindings = actions
    navigation.drawTabs(monitor, TAB_START_LINE)
end

navigation.drawTabs = function(monitor, startLine)
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
    if buttonId and actionBindings[buttonId] then
        actionBindings[buttonId](monitor)
    end
end

navigation.bindActions = function(actionBindings)
    for tabTitle, action in pairs(actionBindings) do
        for i, tab in ipairs(tabs) do
            if tab.title == tabTitle then
                tab.action = action
                break
            end
        end
    end
end

return navigation
