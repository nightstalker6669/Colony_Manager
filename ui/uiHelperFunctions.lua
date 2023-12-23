local uiHelpers = {}

local buttonList = {}

function uiHelpers.drawButton(monitor, x, y, text, buttonId)
    local w, _ = monitor.getSize()
    local width = string.len(text) + 2
    local height = 1
    monitor.setCursorPos(x, y)
    monitor.write("[" .. text .. "]")
    buttonList[buttonId] = { x = x, y = y, width = width, height = height }
end

function uiHelpers.getSelectedButton(touchedX, touchedY, buttonId)
    local button = buttonList[buttonId]
    if button and touchedX >= button.x and touchedX <= (button.x + button.width - 1)
        and touchedY >= button.y and touchedY <= (button.y + button.height) then
        return buttonId
    end
    return nil
end

return uiHelpers
