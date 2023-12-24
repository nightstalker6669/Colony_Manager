-- Utility helper functions for UI

local uiHelpers = {}

local buttonList = {}

local debugLogger = require("utils.debugLogger")

function uiHelpers.drawButton(monitor, x, y, text, buttonId)
    -- Validate coordinates
    uiHelpers.validateButtonCoordinates(x, y) -- Ensure that coordinates are numbers
    local width = string.len(text) + 2
    local height = 1
    monitor.setCursorPos(x, y)
    monitor.write("[" .. text .. "]")
    buttonList[buttonId] = { x = x, y = y, width = width, height = height }
end

function uiHelpers.getSelectedButton(touchedX, touchedY)
    for id, button in pairs(buttonList) do
        if touchedX >= button.x and touchedX <= (button.x + button.width - 1)
           and touchedY >= button.y and touchedY <= (button.y + button.height) then
            return id
        end
    end
    return nil
end

function uiHelpers.validateButtonCoordinates(x, y)
    debugLogger.log("validateButtonCoordinates called with X=" .. tostring(x) .. ", Y=" .. tostring(y))
    if type(x) ~= "number" then
        error("X coordinate must be a number. Received: " .. tostring(x))
    end
    if type(y) ~= "number" then
        error("Y coordinate must be a number. Received: " .. tostring(y))
    end
    return true
end

return uiHelpers
