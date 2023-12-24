-- Module for fetching detailed citizen information
local citizenDetails = {}

function citizenDetails.fetchAllCitizenDetails()
    local integrator = peripheral.find("colonyIntegrator")
    if not integrator then
        error("Could not find a colonyIntegrator peripheral.")
    end
    
    local citizens = integrator.getCitizens()
    local detailedCitizenInfo = {}
    
    for _, citizen in pairs(citizens) do
        -- Extracting the bed position, food saturation, and happiness directly
        table.insert(detailedCitizenInfo, {
            id = citizen.id,
            name = citizen.name,
            age = citizen.age,
            gender = citizen.gender,
            location = citizen.location,
            bedPosition = citizen.bedPos, -- directly using bedPos from citizen
            foodSaturation = citizen.saturation, -- directly using saturation from citizen
            happiness = citizen.happiness -- directly using happiness from citizen
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
        print("Bed position: X=" .. citizen.bedPosition.x .. " Y=" .. citizen.bedPosition.y .. " Z=" .. citizen.bedPosition.z)
        print("Food Saturation: " .. citizen.foodSaturation)
        print("Happiness: " .. citizen.happiness)
        print("------")
    end
end

return citizenDetails
