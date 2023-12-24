-- pageControls module for handling pagination controls on the monitor

local uiHelpers = require("ui.uiHelperFunctions")

local pageControls = {}

function pageControls.showPageControls(monitor, currentPage, totalPages, y)
    local monitorWidth, monitorHeight = monitor.getSize()
    if not y then
       -- Use the bottom row of the monitor if y is not passed
        y = monitorHeight
    end

    -- We subtract 1 because the cursor position is based on 1, not 0
    y = y - 1
    
    if currentPage > 0 then
        uiHelpers.drawButton(monitor, 2, y, "< Prev", "prevPage") 
    end
    if currentPage < totalPages - 1 then
        uiHelpers.drawButton(monitor, monitorWidth - 8, y, "Next >", "nextPage")
    end
end

return pageControls
