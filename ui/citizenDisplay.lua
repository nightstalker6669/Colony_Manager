local pageControls = require("ui.pageControls")


local citizenDisplay = {}

local currentPage = 0

function citizenDisplay.showCitizens(citizens, monitor, currentPage)
  local y = 2
  local citizensPerPage = 4
  local startIndex = currentPage * citizensPerPage + 1
  local endIndex = math.min(startIndex + citizensPerPage - 1, #citizens)
  local totalPages = math.ceil(#citizens / citizensPerPage)

  for i = startIndex, endIndex do
    local citizen = citizens[i]
    y = citizenDisplay.drawCitizenDetails(citizen, monitor, y)
  end

  local _, monitorHeight = monitor.getSize()
  y = monitorHeight - 1
  if totalPages > 1 then
    pageControls.showPageControls(monitor, currentPage, totalPages, y)
  end
end

function citizenDisplay.incrementPage()
  currentPage = currentPage + 1
end

function citizenDisplay.drawCitizenDetails(citizen, monitor, startY)
  local y = startY
  monitor.setCursorPos(1, y)
  monitor.setTextScale(0.5)
  monitor.write('Name: ' .. citizen.name)
  y = y + 1
  monitor.setCursorPos(1, y)
  monitor.write('Age: ' .. citizen.age)
  y = y + 1
  monitor.setCursorPos(1, y)
  monitor.write('Job: ' .. (citizen.job or "N/A"))
  y = y + 1
  monitor.setCursorPos(1, y)
  monitor.write('Location: X=' .. citizen.location.x .. ' Y=' .. citizen.location.y .. ' Z=' .. citizen.location.z)
  y = y + 1
  monitor.setCursorPos(1, y)
  monitor.write('Bed Position: X=' .. citizen.bedPosition.x .. ' Y=' .. citizen.bedPosition.y .. ' Z=' .. citizen.bedPosition.z) // INPUT_REQUIRED {Add implementation for getting citizen's bed position}
  y = y + 1
  monitor.setCursorPos(1, y)
  monitor.write('Food Saturation: ' .. citizen.foodSaturation) // INPUT_REQUIRED {Add implementation for getting citizen's food saturation}
  y = y + 1
  monitor.setCursorPos(1, y)
  monitor.write('Happiness: ' .. citizen.happiness) // INPUT_REQUIRED {Add implementation for getting citizen's happiness}
  y = y + 2

  return y
end

return citizenDisplay
