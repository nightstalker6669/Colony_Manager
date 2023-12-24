local uiHelpers = require("ui.uiHelperFunctions")

local navigation = {}

local tabs
local TAB_START_LINE = 3

function navigation.init(monitor, actions)
    tabs = {
        { ["title"] = "HOME", ["action"] = actions.showHomePage },
        { ["title"] = "CITIZENS", ["action"] = actions.showCitizenDetailsPage }
    }
    navigation.drawTabs(monitor, TAB_START_LINE)
end

function navigation.drawTabs(monitor, startLine)
    monitor.clear()
    local x = 1
    for _, tab in ipairs(tabs) do
        uiHelpers.drawButton(monitor, x, startLine, tab["title"], tab["title"])
        x = x + string.len(tab["title"]) + 3
    end
end

function navigation.handleTabTouch(monitor, x, y)
    for _, tab in ipairs(tabs) do
        local buttonId = uiHelpers.getSelectedButton(x, y, tab.title)
        if buttonId then
            tab.action(monitor)
            break
        end
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
