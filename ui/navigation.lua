-- Navigation management for the advanced monitor interface

local uiHelpers = require("ui.uiHelperFunctions")

local actionBindings = {}
local navigation = {}
local tabs

function navigation.init(monitor, actions)
    tabs = {
        { ["title"] = "HOME", ["action"] = actions.showHomePage },
        { ["title"] = "CITIZENS", ["action"] = actions.showCitizenDetailsPage }
    }
    -- SET TEXT SCALE -- ensure text size is set correctly before drawing tabs.
    monitor.setTextScale(0.5)
    navigation.drawTabs(monitor, tabs) -- pass tabs to the drawTabs function
end

function navigation.drawTabs(monitor, tabList)
    local startLine = _G.TAB_START_LINE
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

function navigation.handleTabTouch(monitor, x, y)
    local selectedButton = uiHelpers.getSelectedButton(x, y)
    if selectedButton and tabs[selectedButton] then
        tabs[selectedButton]["action"]()
    end
end

navigation.bindActions = function(bindings)
    for actionName, action in pairs(bindings) do
        actionBindings[actionName:upper()] = action
    end
end

return navigation
