-- Module for fetching detailed citizen information
local citizenDetails = {}

-- Required imports or other setup code
local peripheral = require('peripheral')

-- Fetch detailed information for all citizens
function citizenDetails.fetchAllCitizenDetails()
    local integrator = peripheral.find("colonyIntegrator")
    if not integrator then
        error("Could not find a colonyIntegrator peripheral.")
    end
    
    local citizens = integrator.getCitizens()
    local detailedCitizenInfo = {}
    
    for _, citizen in pairs(citizens) do
        table.insert(detailedCitizenInfo, {
            id = citizen.id, -- Citizen ID
            name = citizen.name, -- Citizen name
            age = citizen.age, -- Citizen age
            gender = citizen.gender, -- Citizen gender
            location = citizen.location -- Citizen location with x, y, z coordinates
        })
    end
    
    return detailedCitizenInfo
end

-- Fetch extra citizen details such as bed position, food saturation, and happiness
function citizenDetails.fetchExtraCitizenDetails(citizenID)
    local integrator = peripheral.find("colonyIntegrator")
    if not integrator then
        error("Could not find a colonyIntegrator peripheral.")
    end

    local bedPosition = integrator.getBedPosition(citizenID)
    local foodSaturation = integrator.getFoodSaturation(citizenID)
    local happiness = integrator.getCitizenHappiness(citizenID)

    return {
        bedPosition = bedPosition,
        foodSaturation = foodSaturation,
        happiness = happiness
    }
end

-- Log detailed citizen information for diagnostics
function citizenDetails.logCitizenDetails()
    local details = citizenDetails.fetchAllCitizenDetails()
    for i, citizen in ipairs(details) do
        print("Citizen " .. i)
        print("ID: " .. citizen.id)
        print("Name: " .. citizen.name)
        print("Age: " .. citizen.age)
        print("Gender: " .. citizen.gender)
        print("Location: X=" .. citizen.location.x .. " Y=" .. citizen.location.y .. " Z=" .. citizen.location.z)
        print("------")
    end
end

return citizenDetails
