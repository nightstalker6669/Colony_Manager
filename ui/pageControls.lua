-- pageControls module for handling pagination controls on the monitor

local uiHelpers = require("ui.uiHelperFunctions")

local pageControls = {}

function pageControls.showPageControls(monitor, currentPage, totalPages, y)
    local monitorWidth, monitorHeight = monitor.getSize()
    if y == nil then
        y = monitorHeight - 1
    end

    if currentPage > 0 then
        uiHelpers.drawButton(monitor, 2, y, "< Prev", "prevPage")
    end
    if currentPage < totalPages - 1 then
        uiHelpers.drawButton(monitor, monitorWidth - 8, y, "Next >", "nextPage")
    end
end

return pageControls
