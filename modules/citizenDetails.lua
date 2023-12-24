-- Module for fetching detailed citizen information including extra details
local citizenDetails = {}

function citizenDetails.fetchAllCitizenDetails()
    local integrator = peripheral.find("colonyIntegrator")
    if not integrator then
        error("Could not find a colonyIntegrator peripheral.")
    end
    
    local citizens = integrator.getCitizens()
    local detailedCitizenInfo = {}
    
    for _, citizen in pairs(citizens) do
        table.insert(detailedCitizenInfo, {
            id = citizen.id,
            name = citizen.name,
            age = citizen.age,
            gender = citizen.gender,
            location = citizen.location,
            bedPosition = citizen.bedPosition,
            foodSaturation = citizen.foodSaturation,
            happiness = citizen.happiness
        })
    end
    
    return detailedCitizenInfo
end

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
