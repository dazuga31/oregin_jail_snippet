local visualZones = {}

-- Функція для створення зон арешту.
local function createVisualZones()
    for zoneName, zoneData in pairs(Config.ZoneSettings) do
        local visualZone = PolyZone:Create(zoneData.points, {
            name = zoneData.name,
            debugPoly = true
        })
        table.insert(visualZones, visualZone)
    end
end

RegisterCommand("drawjailinZones", function()
    if drawDebug then
        for _, zone in ipairs(visualZones) do
            zone:destroy()
        end
        visualZones = {}
    else
        createVisualZones()
    end
    drawDebug = not drawDebug
    local status = drawDebug and "увімкнено" or "вимкнено"
    if Config.MarkoFederal then
        print(Config.MFederal_lang.DrawJailinZones .. status)
    end
end)

-- Перевірка перед увязненням гравця.
RegisterNUICallback('MarkoPreJailCheck', function(data, cb)
    local citizenID = data.citizenID
    local mesesCondena = tonumber(data.mesesCondena) -- Перетворення на число
    local peligro = data.peligro
    
    if Config.MarkoFederal then
        print(Config.MFederal_lang.MarkoPreJailCheckCalledClient, citizenID, mesesCondena, peligro)
    end
    
    -- Виклик серверної функції для перевірки
    TriggerServerEvent('origen_police:server:MarkoPreJailCheck', data)
    
    -- Очікування відповіді від сервера
    RegisterNetEvent('origen_police:client:MarkoPreJailCheckResult')
    AddEventHandler('origen_police:client:MarkoPreJailCheckResult', function(result, reason)
        if Config.MarkoFederal then
            print(Config.MFederal_lang.ReceivedCallbackResult, result, reason)
        end
        cb({ result = result, reason = reason })
    end)
end)
