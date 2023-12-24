local uiHelpers = require("ui.uiHelperFunctions")

local pageControls = {}

function pageControls.showPageControls(monitor, currentPage, totalPages)
    local monitorWidth, monitorHeight = monitor.getSize()
    if currentPage > 0 then
        uiHelpers.drawButton(monitor, 2, monitorHeight, "< Prev", "prevPage")
    end
    if currentPage < totalPages - 1 then
        uiHelpers.drawButton(monitor, monitorWidth - 8, monitorHeight, "Next >", "nextPage")
    end
end

return pageControls
