-- Utility helper functions for UI

local uiHelpers = {}

local buttonList = {}

function uiHelpers.drawButton(monitor, x, y, text, buttonId)
    -- Ensure that coordinates are numbers
    uiHelpers.validateButtonCoordinates(x, y)
    local width = string.len(text) + 2
    local height = 1 -- Assign a default height for the button
    monitor.setCursorPos(x, y)
    monitor.write("[" .. text .. "]")
    -- Debug log to check if buttonList is correctly populated
    if buttonList[buttonId] then
        error("Button ID '" .. buttonId .. "' is already in use.")
    else
        buttonList[buttonId] = { x = x, y = y, width = width, height = height }
    end
end

function uiHelpers.getSelectedButton(touchedX, touchedY)
    for id, button in pairs(buttonList) do
        if touchedX >= button.x and touchedX <= (button.x + button.width - 1) and touchedY >= button.y and touchedY <= (button.y + button.height) then
            return id
        end
    end
    return nil
end

function uiHelpers.validateButtonCoordinates(x, y)
    if type(x) ~= "number" or type(y) ~= "number" then
        error("Coordinates must be numbers. Received: X=" .. tostring(x) .. ", Y=" .. tostring(y))
    end
    return true
end

function uiHelpers.isButtonDrawn(buttonId)
    return buttonList[buttonId] ~= nil
end

-- Rest of the code...

return uiHelpers
