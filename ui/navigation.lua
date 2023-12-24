-- Navigation management for the advanced monitor interface

local uiHelpers = require("ui.uiHelperFunctions")

local navigation = {}

local tabs
local actionBindings

function navigation.init(monitor, actions)
    tabs = {
        { ["title"] = "HOME", ["action"] = actions.showHomePage },
        { ["title"] = "CITIZENS", ["action"] = actions.showCitizenDetailsPage }
    }
    actionBindings = actions
    navigation.drawTabs(monitor, TAB_START_LINE)
end

function navigation.drawTabs(monitor, startLine)
    monitor.clear()
    local x = 1
    for _, tab in ipairs(tabs) do
        uiHelpers.drawButton(monitor, x, startLine, tab["title"], tab["title"])
        -- Increment the x coordinate by the length of the title and some padding
        x = x + string.len(tab["title"]) + 3
        local monitorWidth, _ = monitor.getSize()
        if x >= monitorWidth then
            -- Reset x to 1 and increment the y coordinate to start a new line of tabs.
            x = 1
            startLine = startLine + 1
        end
    end
end

function navigation.handleTabTouch(monitor, x, y)
    uiHelpers.validateButtonCoordinates(x, y)
    local buttonId = uiHelpers.getSelectedButton(x, y)
    if buttonId and actionBindings[buttonId] then
        actionBindings[buttonId](monitor)
    end
end

-- Function to add action bindings to tabs
function navigation.bindActions(actionBindings)
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
