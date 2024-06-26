Config.MarkoFederal = true


Config.DiscordWebhookURL = 'WEB_HOOK'

-- Налаштування зон в яких відбувається арешт
Config.ZoneSettings = {
    LSPD = {
        name = "LSPD",
        points = {
            vector3(477.04, -1015.38, 27.32),
            vector3(477.04, -1004.86, 26.27),
            vector3(488.12, -1004.54, 26.27),
            vector3(488.16, -1015.42, 26.27)



        }
    },
    LSSD = {
        name = "LSSD",
        points = {
            vector3(1839.94, 3672.31, 34.33),
            vector3(1838.46, 3674.50, 34.33),
            vector3(1846.31, 3679.15, 34.33),
            vector3(1847.76, 3676.85, 34.33)
        }
    }
}


-- Ukrainian Lang
Config.MFederal_lang = {
    MarkoPreJailCheckCalled = '[SERVER]: MarkoPreJailCheck called with Source ID:',
    MarkoPreJailCheckData = '[SERVER]: MarkoPreJailCheck data:',
    SelfArrestAttempt = 'Гравець спробував себе арештувати',
    OfficerInfoName = '[SERVER]: Officer Information - Name:',
    OfficerInfoCitizenID = '[SERVER]: Officer Information - CitizenID:',
    OfficerFaction = '[SERVER]: Officer Faction -',
    OfficerCoordinates = '[SERVER]: Officer Coordinates - X: %.2f, Y: %.2f, Z: %.2f',
    PrisonerInfoName = '[SERVER]: Prisoner Information - Name:',
    PrisonerInfoCitizenID = '[SERVER]: Prisoner Information - CitizenID:',
    PrisonerCoordinates = '[SERVER]: Prisoner Coordinates - X: %.2f, Y: %.2f, Z: %.2f',
    DistanceBetweenOfficerPrisoner = 'Відстань між офіцером та ув\'язненим = %.2f',
    PrisonerNotFound = '[SERVER]: Ув\'язненого не знайдено',
    CheckResultIsValid = '[SERVER]: Check result isValid:',

    MarkoPreJailCheckCalledClient = '[CLIENT]: MarkoPreJailCheck called with:',
    ReceivedCallbackResult = '[CLIENT]: Received callback result from server:',
    DrawJailinZones = 'Відображення зелених зон ',

    -- Дискорд повідомлення
    ArrestNotificationTitle = ':pencil: Арешт виконано :pencil:',
    Officer = 'Офіцер',
    Prisoner = 'Ув\'язнений',
    Date = 'Дата/Час',
    CannotArrestSelf = 'Ви не можете арештувати самого себе!',
    Faction = 'Фракція',
    Rank = 'Ранг',
    Nationality = 'Національність',
    BloodType = 'Група крові',
    PhoneNumber = 'Номер телефону',
    Fingerprint = 'Відбиток пальця',
    Address = 'Місце проживання',
    DateOfBirth = 'Дата народження',
    DiscordNotificationSent = '[SERVER]: Повідомлення в Discord відправлено'
}


--[[
-- Spain Lang
Config.MFederal_lang = {
    MarkoPreJailCheckCalled = '[SERVIDOR]: MarkoPreJailCheck llamado con ID de fuente:',
    MarkoPreJailCheckData = '[SERVIDOR]: Datos de MarkoPreJailCheck:',
    SelfArrestAttempt = 'El jugador intentó arrestarse a sí mismo',
    OfficerInfoName = '[SERVIDOR]: Información del oficial - Nombre:',
    OfficerInfoCitizenID = '[SERVIDOR]: Información del oficial - ID del ciudadano:',
    OfficerFaction = '[SERVIDOR]: Facción del oficial -',
    OfficerCoordinates = '[SERVIDOR]: Coordenadas del oficial - X: %.2f, Y: %.2f, Z: %.2f',
    PrisonerInfoName = '[SERVIDOR]: Información del prisionero - Nombre:',
    PrisonerInfoCitizenID = '[SERVIDOR]: Información del prisionero - ID del ciudadano:',
    PrisonerCoordinates = '[SERVIDOR]: Coordenadas del prisionero - X: %.2f, Y: %.2f, Z: %.2f',
    DistanceBetweenOfficerPrisoner = 'Distancia entre el oficial y el prisionero = %.2f',
    PrisonerNotFound = '[SERVIDOR]: Prisionero no encontrado',
    CheckResultIsValid = '[SERVIDOR]: El resultado de la verificación es válido:',

    MarkoPreJailCheckCalledClient = '[CLIENTE]: MarkoPreJailCheck llamado con:',
    ReceivedCallbackResult = '[CLIENTE]: Resultado de la llamada recibido del servidor:',
    DrawJailinZones = 'Visualización de zonas verdes',

    -- Notificación de Discord
    ArrestNotificationTitle = ':pencil: Arresto realizado :pencil:',
    Officer = 'Oficial',
    Prisoner = 'Prisionero',
    Date = 'Fecha/Hora',
    CannotArrestSelf = '¡No puedes arrestarte a ti mismo!',
    Faction = 'Facción',
    Rank = 'Rango',
    Nationality = 'Nacionalidad',
    BloodType = 'Tipo de sangre',
    PhoneNumber = 'Número de teléfono',
    Fingerprint = 'Huella dactilar',
    Address = 'Dirección',
    DateOfBirth = 'Fecha de nacimiento',
    DiscordNotificationSent = '[SERVIDOR]: Notificación enviada a Discord'
}


Config.MFederal_lang = {
    MarkoPreJailCheckCalled = '[SERVER]: MarkoPreJailCheck called with Source ID:',
    MarkoPreJailCheckData = '[SERVER]: MarkoPreJailCheck data:',
    SelfArrestAttempt = 'Player attempted to arrest themselves',
    OfficerInfoName = '[SERVER]: Officer Information - Name:',
    OfficerInfoCitizenID = '[SERVER]: Officer Information - Citizen ID:',
    OfficerFaction = '[SERVER]: Officer Faction -',
    OfficerCoordinates = '[SERVER]: Officer Coordinates - X: %.2f, Y: %.2f, Z: %.2f',
    PrisonerInfoName = '[SERVER]: Prisoner Information - Name:',
    PrisonerInfoCitizenID = '[SERVER]: Prisoner Information - Citizen ID:',
    PrisonerCoordinates = '[SERVER]: Prisoner Coordinates - X: %.2f, Y: %.2f, Z: %.2f',
    DistanceBetweenOfficerPrisoner = 'Distance between officer and prisoner = %.2f',
    PrisonerNotFound = '[SERVER]: Prisoner not found',
    CheckResultIsValid = '[SERVER]: Check result isValid:',

    MarkoPreJailCheckCalledClient = '[CLIENT]: MarkoPreJailCheck called with:',
    ReceivedCallbackResult = '[CLIENT]: Received callback result from server:',
    DrawJailinZones = 'Displaying green zones',

    -- Discord notification
    ArrestNotificationTitle = ':pencil: Arrest made :pencil:',
    Officer = 'Officer',
    Prisoner = 'Prisoner',
    Date = 'Date/Time',
    CannotArrestSelf = 'You cannot arrest yourself!',
    Faction = 'Faction',
    Rank = 'Rank',
    Nationality = 'Nationality',
    BloodType = 'Blood Type',
    PhoneNumber = 'Phone Number',
    Fingerprint = 'Fingerprint',
    Address = 'Address',
    DateOfBirth = 'Date of Birth',
    DiscordNotificationSent = '[SERVER]: Notification sent to Discord'
}

]]