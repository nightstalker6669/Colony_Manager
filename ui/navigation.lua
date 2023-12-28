-- Navigation management for the advanced monitor interface

local uiHelpers = require("ui.uiHelperFunctions")

local actionBindings = {}
local navigation = {}
local TAB_START_LINE = 3

function navigation.init(monitor, actions)
    local tabs = {
        { title = "HOME", action = actions.showHomePage },
        { title = "CITIZENS", action = actions.showCitizenDetailsPage },
        { title = "STATISTICS", action = actions.showStatisticsPage },
        { title = "SETTINGS", action = actions.showSettingsPage }
    }
    -- SET TEXT SCALE -- ensure text size is set correctly before drawing tabs.
    monitor.setTextScale(0.5)
    navigation.drawTabs(monitor, TAB_START_LINE, tabs) -- pass tabs to the drawTabs function
end

function navigation.drawTabs(monitor, startLine, tabList)
    monitor.clear()
    local x = 1
    for _, tab in ipairs(tabList) do
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

-- Rest of the navigation.lua code...

navigation.bindActions = function(bindings)
    for actionName, action in pairs(bindings) do
        actionBindings[actionName:upper()] = action
    end
end

return navigation
