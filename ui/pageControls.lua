local uiHelpers = require("ui.uiHelperFunctions")

local pageControls = {}

function pageControls.showPageControls(monitor, currentPage, totalPages, y)
    local monitorWidth, monitorHeight = monitor.getSize()
    -- Initialize y to the last line of the monitor if it's nil
    y = y or monitorHeight

    if currentPage > 0 then
        -- Adding checks to ensure we do not call drawButton with nil for y
        assert(type(y) == "number", "Y coordinate must be a number for page controls.")
        uiHelpers.drawButton(monitor, 2, y, "< Prev", "prevPage")
    end
    if currentPage < totalPages - 1 then
        -- Adding checks to ensure we do not call drawButton with nil for y
        assert(type(y) == "number", "Y coordinate must be a number for page controls.")
        uiHelpers.drawButton(monitor, monitorWidth - 8, y, "Next >", "nextPage")
    end
end

return pageControls
