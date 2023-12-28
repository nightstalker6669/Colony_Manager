-- Navigation management for the advanced monitor interface

local uiHelpers = require("ui.uiHelperFunctions")

local actionBindings = {} -- Initialising the actionBindings variable
local navigation = {}
local tabs

function navigation.init(monitor, actions)
    tabs = {
        { ["title"] = "HOME", ["action"] = actions.showHomePage },
        { ["title"] = "CITIZENS", ["action"] = actions.showCitizenDetailsPage }
    }
    -- SET TEXT SCALE -- ensure text size is set correctly before drawing tabs.
    monitor.setTextScale(0.5)
    navigation.drawTabs(monitor, tabs)
end

navigation.drawTabs = function(monitor, tabs)
    local startLine = _G.TAB_START_LINE
    monitor.clear()
    local x = 1
    for _, tab in ipairs(tabs) do
        if not uiHelpers.isButtonDrawn(tab["title"]) then
            uiHelpers.drawButton(monitor, x, startLine, tab["title"], tab["title"])
            x = x + string.len(tab["title"]) + 3
            local monitorWidth, _ = monitor.getSize()
            if x >= monitorWidth then
                x = 1
                startLine = startLine + 1
            end
        end
    end
end

navigation.handleTabTouch = function(monitor, x, y)
    uiHelpers.validateButtonCoordinates(x, y)
    local buttonId = uiHelpers.getSelectedButton(x, y)
    if buttonId then
        local actionName = buttonId:upper()
        if actionBindings[actionName] then
            actionBindings[actionName]()
        end
    end
end

navigation.bindActions = function(bindings)
    for tabTitle, action in pairs(bindings) do
        actionBindings[tabTitle:upper()] = action
    end
end

return navigation
