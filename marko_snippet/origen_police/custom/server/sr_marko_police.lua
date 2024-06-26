QBCore = exports['qb-core']:GetCoreObject()

-- НЕ ЗАБУВАЙ ПРО ГРАМАТИКУ

local function isPointInPoly(point, poly)
    local inside = false
    local x, y = point.x, point.y
    local j = #poly

    for i = 1, #poly do
        local xi, yi = poly[i].x, poly[i].y
        local xj, yj = poly[j].x, poly[j].y
        local intersect = ((yi > y) ~= (yj > y)) and (x < (xj - xi) * (y - yi) / (yj - yi) + xi)
        if intersect then
            inside = not inside
        end
        j = i
    end

    return inside
end

local nationalityEmojis = {
    ["Ukraine"] = ":flag_ua:",
    ["American"] = ":flag_us:",
    ["British"] = ":flag_gb:",
    ["French"] = ":flag_fr:",
    -- Додайте інші національності за необхідності
}

local function getNationalityEmoji(nationality)
    return nationalityEmojis[nationality] or ":flag_white:" -- Повертає білий прапор, якщо національність не знайдено
end

-- Таблиця URL зображень для різних фракцій
local factionThumbnails = {
    police = "https://media.discordapp.net/attachments/1167773064906424403/1255552144099119196/police.png?ex=667d8b8e&is=667c3a0e&hm=02fe06ea7b652f7fa8f48b31923476fc0825f56e84ff35c5eb5a57a75bb21a90&=&format=webp&quality=lossless&width=750&height=750",
    ambulance = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Star_of_life.svg/640px-Star_of_life.svg.png",
    police2 = "https://media.discordapp.net/attachments/1167773064906424403/1255552144434528426/police2.png?ex=667d8b8e&is=667c3a0e&hm=35942e63207de7a0a7139a3b0f465d5e66235a6c2a62c71592c8b82881930d3d&=&format=webp&quality=lossless&width=750&height=750",
    gow = "https://media.discordapp.net/attachments/1167773064906424403/1255552144753557596/gow.png?ex=667d8b8e&is=667c3a0e&hm=eb06cc9ee7ba0a6b7e3a129dd22468d1c6ff439b10c0c2125d8819a0e6697b99&=&format=webp&quality=lossless&width=750&height=750",
    ambulance = "https://media.discordapp.net/attachments/1167773064906424403/1255552145441423411/ambulance.png?ex=667d8b8e&is=667c3a0e&hm=cbdd59ad3c760eb9c5bf4f3157f6b9fcfa3f5747b7d5b5b1caf918e3971d2b02&=&format=webp&quality=lossless&width=750&height=750",
    judge = "https://media.discordapp.net/attachments/1167773064906424403/1255552145097359442/judge.png?ex=667d8b8e&is=667c3a0e&hm=650e7fa53320c2ef1745dd8a397706ee62b1ac12888e735b606c65d2d6063ce2&=&format=webp&quality=lossless&width=750&height=750",
    default = "https://via.placeholder.com/150" -- Можете встановити інше зображення за замовчуванням
}

local function getFactionThumbnail(faction)
    return factionThumbnails[faction] or factionThumbnails.default
end

local function sendDiscordArrestNotification(officer, prisoner, dateTime)
    local embed = {
        {
            ["title"] = Config.MFederal_lang.ArrestNotificationTitle,
            ["color"] = 3447003, -- Blue
            ["fields"] = {
                {["name"] = ":police_officer: " .. Config.MFederal_lang.Officer, ["value"] = officer.name, ["inline"] = true},
                {["name"] = ":id: CitizenID", ["value"] = officer.citizenID, ["inline"] = true},
                {["name"] = ":office_worker: " .. Config.MFederal_lang.Faction, ["value"] = officer.faction, ["inline"] = true},
                {["name"] = ":military_medal: " .. Config.MFederal_lang.Rank, ["value"] = officer.rank, ["inline"] = true},
                {["name"] = "⠀", ["value"] = "⠀"}, -- Розділювач
                {["name"] = ":bust_in_silhouette: " .. Config.MFederal_lang.Prisoner, ["value"] = prisoner.name, ["inline"] = true},
                {["name"] = ":id: CitizenID", ["value"] = prisoner.citizenID, ["inline"] = true},
                {["name"] = getNationalityEmoji(prisoner.nationality) .. " " .. Config.MFederal_lang.Nationality, ["value"] = prisoner.nationality, ["inline"] = true},
                {["name"] = ":drop_of_blood: " .. Config.MFederal_lang.BloodType, ["value"] = prisoner.bloodType, ["inline"] = true},
                {["name"] = ":mobile_phone: " .. Config.MFederal_lang.PhoneNumber, ["value"] = prisoner.phoneNumber, ["inline"] = true},
                {["name"] = ":raised_hand: " .. Config.MFederal_lang.Fingerprint, ["value"] = prisoner.fingerprint, ["inline"] = true},
                {["name"] = ":house: " .. Config.MFederal_lang.Address, ["value"] = prisoner.address, ["inline"] = true},
                {["name"] = ":birthday: " .. Config.MFederal_lang.DateOfBirth, ["value"] = prisoner.dateOfBirth, ["inline"] = true},
                {["name"] = ":clock1: " .. Config.MFederal_lang.Date, ["value"] = dateTime, ["inline"] = true}
            },
            ["thumbnail"] = {
                ["url"] = getFactionThumbnail(officer.faction)
            }
        }
    }

    PerformHttpRequest(Config.DiscordWebhookURL, function(err, text, headers) 
        if Config.MarkoFederal then
            print(Config.MFederal_lang.DiscordNotificationSent)
        end
    end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('origen_police:server:MarkoPreJailCheck')
AddEventHandler('origen_police:server:MarkoPreJailCheck', function(data)
    local source = source
    local targetPlayerID = tonumber(data.citizenID) -- ID гравця, якого мають ув'язнити
    local mesesCondena = tonumber(data.mesesCondena) -- Перетворення на число
    local peligro = data.peligro

    if Config.MarkoFederal then
        print(Config.MFederal_lang.MarkoPreJailCheckCalled, source)
        print(Config.MFederal_lang.MarkoPreJailCheckData, targetPlayerID, mesesCondena, peligro)
    end

    -- Ініціалізація змінних перевірки
    local isValid = true
    local reason = ""

    -- Перевірка на арешт самого себе
    if source == targetPlayerID then
        isValid = false
        reason = Config.MFederal_lang.CannotArrestSelf
        if Config.MarkoFederal then
            print(Config.MFederal_lang.SelfArrestAttempt)
        end
    else
        -- Отримання інформації про офіцера з використанням QBcore
        local Officer = QBCore.Functions.GetPlayer(source)
        local officerName = Officer.PlayerData.charinfo.firstname .. ' ' .. Officer.PlayerData.charinfo.lastname
        local officerCitizenID = Officer.PlayerData.citizenid
        local faction = Officer.PlayerData.job.name
        local factionRank = Officer.PlayerData.job.grade.name

        -- Отримання координат офіцера (source)
        local officerCoords = GetEntityCoords(GetPlayerPed(source))
        local officerX, officerY, officerZ = table.unpack(officerCoords)

        if Config.MarkoFederal then
            print(Config.MFederal_lang.OfficerInfoName, officerName)
            print(Config.MFederal_lang.OfficerInfoCitizenID, officerCitizenID)
            print(Config.MFederal_lang.OfficerFaction, faction, '-', factionRank)
            print(string.format(Config.MFederal_lang.OfficerCoordinates, officerX, officerY, officerZ))
        end

        -- Отримання інформації про ув'язненого з використанням QBcore
        local Prisoner = QBCore.Functions.GetPlayer(targetPlayerID)
        if Prisoner then
            local prisonerCoords = GetEntityCoords(GetPlayerPed(Prisoner.PlayerData.source))
            local prisonerX, prisonerY, prisonerZ = table.unpack(prisonerCoords)

            local prisonerName = Prisoner.PlayerData.charinfo.firstname .. ' ' .. Prisoner.PlayerData.charinfo.lastname
            local prisonerCitizenID = Prisoner.PlayerData.citizenid
            local prisonerNationality = Prisoner.PlayerData.charinfo.nationality or "Невідомо"
            local prisonerBloodType = Prisoner.PlayerData.metadata.bloodtype or "Невідомо"
            local prisonerPhoneNumber = Prisoner.PlayerData.charinfo.phone or "Невідомо"
            local prisonerFingerprint = Prisoner.PlayerData.metadata.fingerprint or "Невідомо"
            local prisonerAddress = Prisoner.PlayerData.charinfo.address or "Невідомо"
            local prisonerDateOfBirth = Prisoner.PlayerData.charinfo.birthdate or "Невідомо"
            
            if Config.MarkoFederal then
                print(Config.MFederal_lang.PrisonerInfoName, prisonerName)
                print(Config.MFederal_lang.PrisonerInfoCitizenID, prisonerCitizenID)
                print(string.format(Config.MFederal_lang.PrisonerCoordinates, prisonerX, prisonerY, prisonerZ))
            end

            -- Обчислення відстані між офіцером та ув'язненим
            local distance = math.sqrt((officerX - prisonerX)^2 + (officerY - prisonerY)^2 + (officerZ - prisonerZ)^2)
            if Config.MarkoFederal then
                print(string.format(Config.MFederal_lang.DistanceBetweenOfficerPrisoner, distance))
            end
            
            -- Перевірка відстані між гравцями
            if distance > 3.0 then
                isValid = false
                reason = "Громадянин занадто далеко від вас!"
            end

            -- Перевірка чи обидва гравці знаходяться у зоні
            local lspdZone = Config.ZoneSettings.LSPD.points
            local lssdZone = Config.ZoneSettings.LSSD.points

            if not isPointInPoly(officerCoords, lspdZone) and not isPointInPoly(officerCoords, lssdZone) then
                isValid = false
                reason = "Ви занадто далеко до місця ув'язнення!"
            elseif not isPointInPoly(prisonerCoords, lspdZone) and not isPointInPoly(prisonerCoords, lssdZone) then
                isValid = false
                reason = "Ув'язнений занадто далеко до місця ув'язнення!"
            end

            if isValid then
                -- Відправка повідомлення до Discord
                local dateTime = os.date('%Y-%m-%d %H:%M:%S', os.time())
                sendDiscordArrestNotification(
                    {
                        name = officerName,
                        citizenID = officerCitizenID,
                        faction = faction,
                        rank = factionRank
                    },
                    {
                        name = prisonerName,
                        citizenID = prisonerCitizenID,
                        nationality = prisonerNationality,
                        bloodType = prisonerBloodType,
                        phoneNumber = prisonerPhoneNumber,
                        fingerprint = prisonerFingerprint,
                        address = prisonerAddress,
                        dateOfBirth = prisonerDateOfBirth
                    },
                    dateTime
                )
            end

        else
            if Config.MarkoFederal then
                print(Config.MFederal_lang.PrisonerNotFound)
            end
            isValid = false
            reason = "Ув'язненого не знайдено"
        end
    end

    -- Логіка перевірки (приклад)
    if mesesCondena > 60 then
        isValid = false
        reason = "Час арешту не може перевищувати 60 днів"
    elseif targetPlayerID == nil or mesesCondena <= 0 then
        isValid = false
        reason = "Невірні дані арешту"
    end

    if Config.MarkoFederal then
        print(Config.MFederal_lang.CheckResultIsValid, isValid)
    end

    -- Відправка результату клієнту
    TriggerClientEvent('origen_police:client:MarkoPreJailCheckResult', source, isValid, reason)
end)