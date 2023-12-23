local displayManager = require("ui.displayManager")

local navigation = {}

function navigation.handleTabTouch(x, y)
    if x >= 1 and x <= 5 and y == 1 then
        displayManager.showHomePage()
    elseif x >= 6 and x <= 15 and y == 1 then
        displayManager.showCitizenDetailsPage()
    end
end

return navigation
