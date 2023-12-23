-- Interacting with the minecolonies mod via the colonyIntegrator block
local colonyData = {}

function colonyData.fetchBasicColonyData()
    -- Using peripheral.find to automatically find the colonyIntegrator block
    local integrator = peripheral.find("colonyIntegrator")

    if not integrator then
        error("Could not find a colonyIntegrator peripheral. Is it correctly attached to the computer?")
    end

    -- Using the correct methods provided by the colonyIntegrator API
    local colonyID = integrator.getColonyID()
    local colonyName = integrator.getColonyName()
    local happiness = integrator.getHappiness()
    local amountOfCitizens = integrator.amountOfCitizens()
    local maxOfCitizens = integrator.maxOfCitizens()
    local amountOfGraves = integrator.amountOfGraves()
    local amountOfConstructionSites = integrator.amountOfConstructionSites()

    -- Prepare a table with basic colony data
    local data = {
        colonyID = colonyID,
        colonyName = colonyName,
        happiness = happiness,
        citizenCount = amountOfCitizens,
        citizenCapacity = maxOfCitizens,
        gravesCount = amountOfGraves,
        constructionSitesCount = amountOfConstructionSites,
    }

    -- Print out the data for inspection
    for k, v in pairs(data) do
        print(k .. ": " .. tostring(v))
    end

    return data
end

return colonyData
