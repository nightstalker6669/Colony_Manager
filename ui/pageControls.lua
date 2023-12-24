local uiHelpers = require("ui.uiHelperFunctions")

local pageControls = {}

function pageControls.showPageControls(monitor, currentPage, totalPages, y)
    local monitorWidth, _ = monitor.getSize()
    if currentPage > 0 then
        uiHelpers.drawButton(monitor, 2, y, "< Prev", "prevPage")
    end
    if currentPage < totalPages - 1 then
        uiHelpers.drawButton(monitor, monitorWidth - 8, y, "Next >", "nextPage")
    end
end

return pageControls
