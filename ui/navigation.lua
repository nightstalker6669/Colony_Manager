local uiHelpers = require("ui.uiHelperFunctions")

local navigation = {}

local tabs

function navigation.init(monitor, actions)
    tabs = {
        { ["title"] = "HOME", ["action"] = actions.showHomePage },
        { ["title"] = "CITIZENS", ["action"] = actions.showCitizenDetailsPage }
    }
    
    local w, _ = monitor.getSize()
    local x = 1
    for _, tab in ipairs(tabs) do
        uiHelpers.drawButton(monitor, x, 1, tab["title"], tab["title"])
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

return navigation
